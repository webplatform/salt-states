mediawiki_jobrunner_cron:
  cron.present:
    - user: www-data
    - name: '/usr/bin/php /srv/webplatform/wiki/current/maintenance/runJobs.php'
