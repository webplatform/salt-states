{#
 # Piwik Salt stack config
 #
 # See also:
 #   - https://github.com/perusio/piwik-nginx.git
 #}
include:
  - nginx

/etc/nginx/sites-available/stats:
  file.managed:
    - source: salt://piwik/files/vhost.nginx.conf.jinja
    - template: jinja
    - context:
        tld: {{ salt['pillar.get']('infra:current:tld', 'webplatform.org') }}
    - watch_in:
      - service: nginx
    - require:
      - pkg: nginx

/etc/nginx/sites-enabled/stats:
  file.symlink:
    - target: /etc/nginx/sites-available/stats
    - require:
      - pkg: nginx
      - file: /etc/nginx/sites-available/stats

