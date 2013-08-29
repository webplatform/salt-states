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
#        - watch:
#            - file: /etc/php5/conf.d/php.ini
        - reload: True
        - require:
            - pkg: php

{% for site, args in pillar.get('sites', {}).items() %}
{% if 'php' in args and args.php == True %}
/etc/php5/fpm/pool.d/{{ site }}.conf:
    file.managed:
        - source: salt://php/fpm-site.conf
        - template: jinja
        - context:
            site: {{ site }}
            args: {{ args }}
        - watch_in:
            - service: php
        - require:
            - pkg: php
{% else %}
/etc/php5/fpm/pool.d/{{ site }}.conf:
    file.absent:
        - require:
            - pkg: php
{% endif %}
{% endfor %}
