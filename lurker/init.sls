{##
 # Web based email archive manager
 #
 # Ref:
 #   - http://blog.thecodingmachine.com/fr/content/triggering-php-script-when-your-postfix-server-receives-mail
 #   - http://www.serveridol.com/2011/04/26/postfix-piping-all-mails-to-custom-script/
 #   - http://terpstra.ca/lurker/list/lurker-users.en.html
 #
 ##}
include:
  - cron

lurker:
  pkg.installed

/etc/lurker/lurker.conf.local:
  file.managed:
    - source: salt://lurker/files/lurker.conf.local.jinja
    - template: jinja

/var/lib/lurker:
  file.directory:
    - user: www-data
    - group: www-data
    - file_mode: 664
    - require:
      - pkg: lurker
    - recurse:
      - user
      - group
      - mode

/etc/lurker/ui/default.css:
  file.append:
    - require:
      - pkg: lurker
    - text: |
        body,.header,.footer {
          background-color: white !important;
        }
        .header .external .root img {
          display: none;
        }
        .header h1 {
          background: #FFF url(//www.webplatform.org/assets/logo.svg) no-repeat scroll center left;
          padding: 25px 0 25px 70px;
        }

/usr/sbin/lurker-crontab.sh:
  file.managed:
    - source: salt://lurker/files/cronjob.sh
    - mode: 755
    - require:
      - pkg: lurker
      - file: /var/lib/lurker

/etc/cron.d/lurker:
  file.managed:
    - contents: |
        */15 * * * * www-data JOBNAME=lurker cronhelper.sh /usr/sbin/lurker-crontab.sh
    - require:
      - file: /usr/sbin/lurker-crontab.sh
      - file: /usr/bin/cronhelper.sh
