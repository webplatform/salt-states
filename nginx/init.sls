# source: https://github.com/kevva/states/blob/master/nginx/
nginx:
    pkg:
        - installed
    service.running:
        - enable: True
        - watch:
            - file: /etc/nginx/mime.types
            - file: /etc/nginx/nginx.conf
            - file: /etc/nginx/custom.d/*.conf
        - reload: True
        - require:
            - pkg: nginx

fastcgi-orig:
  file.managed:
    - name: /etc/nginx/fastcgi_params
    - source: salt://nginx/files/fastcgi_params
    - user: root
    - group: root
    - require:
      - pkg: nginx

php5-fpm:
  service.running:
    - enable: True
    - require:
      - pkg: nginx
  pkg:
    - installed

purge-apache:
  pkg.purged:
    - pkgs:
      - apache2.2-bin
      - apache2.2-common
      - libapache2-mod-php5

/etc/nginx/nginx.conf:
    file.managed:
        - source: salt://nginx/files/nginx.conf
        - template: jinja

/etc/nginx/mime.types:
    file.managed:
        - source: salt://nginx/files/mime.types
        - require:
            - pkg: nginx

/etc/nginx/custom.d:
    file.directory:
        - makedirs: True
        - require:
            - pkg: nginx

/etc/nginx/custom.d/optimize.conf:
    file.managed:
        - source: salt://nginx/files/optimize.conf
        - require:
            - pkg: nginx
            - file: /etc/nginx/custom.d

/var/cache/nginx:
    file.directory:
        - user: www-data
        - group: www-data
        - makedirs: True
        - require:
            - pkg: nginx
