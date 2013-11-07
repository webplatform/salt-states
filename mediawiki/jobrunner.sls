/usr/bin/mediawiki-runJobs.sh:
  file.managed:
    - mode: 755 
    - user: www-data
    - group: www-data
    - source: salt://mediawiki/files/mediawiki-runJobs.sh

mediawiki_cron_1:
  cron.present:
    - user: www-data
    - minute: random
    - name: "/usr/bin/mediawiki-runJobs.sh #1st run"
    - require:
      - file: /usr/bin/mediawiki-runJobs.sh

mediawiki_cron_2:
  cron.present:
    - minute: random
    - user: www-data
    - name: "/usr/bin/mediawiki-runJobs.sh #2nd run"
    - require:
      - file: /usr/bin/mediawiki-runJobs.sh
