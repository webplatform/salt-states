{%- set ip4_interfaces = salt['grains.get']('ip4_interfaces:eth0') -%}
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

nginx:
  pkg.installed:
    - pkgs:
      - nginx-extras
  service.running:
    - enable: True
    - reload: True
    - require:
      - pkg: nginx-superseeds-apache

/etc/nginx/sites-enabled/default:
  file.absent

/etc/nginx/conf.d/status.conf:
  file.managed:
    - source: salt://nginx/files/status.conf.jinja
    - template: jinja
    - require:
      - pkg: nginx
      - file: /etc/nginx/status.d
    - watch_in:
      - service: monit

nginx-superseeds-apache:
  pkg.purged:
    - pkgs:
      - apache2.2-bin
      - apache2.2-common
      - libapache2-mod-php5

/etc/nginx/status.d:
  file.directory:
    - user: www-data
    - group: www-data
    - makedirs: True

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

{% for file in ['ssl_params', 'common_params', 'fastcgi_params'] %}
/etc/nginx/{{ file }}:
  file.managed:
    - source: salt://nginx/files/{{ file }}.jinja
    - template: jinja
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

