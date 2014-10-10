/usr/bin/buggenie-mailqueue.sh:
  file.managed:
    - mode: 755
    - user: www-data
    - group: www-data
    - source: salt://buggenie/files/buggenie-mailqueue.sh
  cron.present:
    - identifier: buggenie-mailqueue
    - user: www-data
    - minute: '*/5'
    - require:
      - file: /usr/bin/buggenie-mailqueue.sh
