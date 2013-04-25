ntpupdate:
  cron.present:
    - user: root
    - minute: 0
    - hour: 0
    - name: 'ntpdate ntp.ubuntu.com'
