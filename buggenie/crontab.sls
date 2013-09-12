buggenie_mail_cron:
  cron.present:
    - minute: 5
    - user: root
    - name: '/usr/bin/php /srv/webplatform/buggenie/tbg_cli mailing:process_mail_queue --limit=20 > /dev/null'
