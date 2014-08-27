coreutils:
  pkg.installed

# run-one on ubuntu 12.4 would be useful too

/srv/webplatform/wiki/mediawiki-runJobs.sh:
  file.managed:
    - mode: 755 
    - user: ubuntu
    - group: ubuntu
    - source: salt://mediawiki/files/mediawiki-runJobs.sh

mediawiki_cron_1:
  cron.present:
    - user: ubuntu
    - minute: random
    - name: "/srv/webplatform/wiki/mediawiki-runJobs.sh #1st run"
    - require:
      - file: /srv/webplatform/wiki/mediawiki-runJobs.sh

mediawiki_cron_2:
  cron.present:
    - minute: random
    - user: ubuntu
    - name: "/srv/webplatform/wiki/mediawiki-runJobs.sh #2nd run"
    - require:
      - file: /srv/webplatform/wiki/mediawiki-runJobs.sh
