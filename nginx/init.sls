{%- set ip4_interfaces = salt['grains.get']('ip4_interfaces:eth0') -%}
{%- set salt_master_ip = salt['pillar.get']('infra:hosts_entries:salt') -%}
{%- set tld            = salt['pillar.get']('infra:current:tld', 'webplatform.org') -%}
{#
 # NGINX common states
 #
 # See also:
 #   - https://github.com/kevva/states/blob/master/nginx/
 #   - [Difference between NGINX versions](https://gist.github.com/jpetazzo/1152774)
 #   - [Strong SSL security on NGINX](https://raymii.org/s/tutorials/Strong_SSL_Security_On_nginx.html)
 #   - http://nginx.org/en/docs/http/ngx_http_core_module.html#variables
 #   - http://www.cyberciti.biz/faq/custom-nginx-maintenance-page-with-http503/
 #   - [All static files will be served directly?](http://stackoverflow.com/questions/19515132/nginx-cache-static-files#answer-20843725)
 #   - https://www.varnish-cache.org/docs/3.0/tutorial/websockets.html
 #   - http://thruflo.com/post/23226473852/websockets-varnish-nginx
 #}
include:
  - mmonit
  - nginx.status

nginx:
  pkg.installed:
    - pkgs:
      - nginx-extras
  service.running:
    - enable: True
    - reload: True
    - require:
      - pkg: nginx-superseeds-apache

nginx-superseeds-apache:
  pkg.purged:
    - pkgs:
      - apache2.2-bin
      - apache2.2-common
      - libapache2-mod-php5

/var/cache/nginx:
  file.directory:
    - user: www-data
    - group: www-data
    - makedirs: True
    - require:
      - pkg: nginx

nginx-ppa:
  pkgrepo.managed:
    - ppa: nginx/stable
    - require_in:
      - pkg: nginx

{% for file in ['ssl_params',
                'common_params',
                'fastcgi_params'] %}
/etc/nginx/{{ file }}:
  file.managed:
    - source: salt://nginx/files/{{ file }}.jinja
    - template: jinja
    - context:
        salt_master_ip: {{ salt_master_ip }}
    - require:
      - pkg: nginx
{% endfor %}

/etc/monit/conf.d/nginx.conf:
  file.managed:
    - source: salt://nginx/files/monit.conf.jinja
    - template: jinja
    - context:
        private_ip: {{ ip4_interfaces[0] }}
    - require:
      - service: nginx
    - watch_in:
      - service: monit

