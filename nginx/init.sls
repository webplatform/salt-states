# source: https://github.com/kevva/states/blob/master/nginx/
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
  file.absent:
    - require:
      - pkg: nginx

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

