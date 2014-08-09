apache2:
  service:
    - running
    - enable: True
    - reload: true
    - require:
      - pkg: apache2
    - watch:
      - pkg: apache2
  pkg:
    - installed
    - name: apache2-mpm-prefork

/etc/apache2/sites-enabled/000-default:
  file.absent:
    - watch_in:
      - service: apache2

{% if grains['lsb_distrib_release'] == "14.04" %}
/etc/apache2/conf-enabled/performance.conf:
{% else %}
/etc/apache2/conf.d/performance:
{% endif %}
  file.managed:
    - source: salt://apache/performance.jinja
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - watch_in:
      - service: apache2
