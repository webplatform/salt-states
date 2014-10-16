# Based on https://github.com/kevva/states
# In isolation only for Piwik:[piwik1,piwik2] at the moment
include:
    - nginx

php:
    pkg.installed:
        - pkgs:
            - php5-fpm
        - require:
            - pkg: nginx
    service.running:
        - name: php5-fpm
        - enable: True
        - reload: True
        - require:
            - pkg: php
