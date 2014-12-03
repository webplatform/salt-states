{#
 # Piwik Salt stack config
 #
 # See also:
 #   - https://github.com/perusio/piwik-nginx.git
 #}
include:
  - nginx

/etc/nginx/conf.d/geoip.conf:
  file.managed:
    - source: salt://piwik/files/nginx.geoip.conf
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: nginx
      - pkg: piwik-geoip

/etc/nginx/sites-available/piwik:
  file.managed:
    - source: salt://piwik/files/vhost.nginx.conf.jinja
    - template: jinja
    - context:
        site: piwik
        fastcgi_pass_value: {{ salt['grains.get']('ipaddr', '127.0.0.1') }}:9000
    - watch_in:
      - service: nginx
    - require:
      - pkg: nginx

/etc/nginx/sites-enabled/piwik:
  file.symlink:
    - target: /etc/nginx/sites-available/piwik
    - require:
      - pkg: nginx
      - file: /etc/nginx/sites-available/piwik

