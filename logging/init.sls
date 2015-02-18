rsyslog:
  service:
    - running

/etc/rsyslog.d/60-local1.conf:
  file.managed:
    - source: salt://logging/files/60-local1.conf.jinja
    - user: root
    - group: root
    - mode: 444
    - template: jinja
    - context:
        salt_master_ip: {{ salt['pillar.get']('infra:hosts_entries:salt', '127.0.0.1') }}
    - watch_in:
      - service: rsyslog

