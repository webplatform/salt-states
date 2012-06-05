apache2:
  pkg:
    - installed
  service:
    - running
    - enable: True
    - require:
      - pkg: apache2

/etc/apache2/sites-enabled/000-default:
  file.absent:
    - watch_in:
      - service: apache2
