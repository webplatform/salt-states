mediawiki_jobrunner_current_cron:
  cron.absent:
    - minute: random
    - user: www-data
    - name: '/usr/bin/php /srv/webplatform/wiki/current/maintenance/runJobs.php'

mediawiki_jobrunner_current_cron_1:
  cron.present:
    - minute: random
    - user: www-data
    - name: '/usr/bin/php /srv/webplatform/wiki/current/maintenance/runJobs.php #1st run'

mediawiki_jobrunner_current_cron_2:
  cron.present:
    - minute: random
    - user: www-data
    - name: '/usr/bin/php /srv/webplatform/wiki/current/maintenance/runJobs.php #2nd run'

mediawiki_jobrunner_test_cron:
  cron.absent:
    - minute: random
    - user: www-data
    - name: '/usr/bin/php /srv/webplatform/wiki/test/maintenance/runJobs.php'
