ntpupdate:
  cron.present:
    - identifier: ntpdate
    - name: 'JOBNAME=ntpdate cronhelper.sh /usr/sbin/ntpdate -u pool.ntp.org'
    - user: root
    - minute: 0
    - hour: 0
