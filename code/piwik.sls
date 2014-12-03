include:
  - rsync.secret
  - code.prereq

#//github.com/piwik/piwik.git
#2.9.1

# @salt-master-dest
sync-piwik:
  cmd.run:
    - name: "rsync -a --exclude 'tmp' --exclude '.git' --exclude '.svn' --delete --no-perms --password-file=/etc/codesync.secret codesync@salt::code/piwik/repo/ /srv/webplatform/piwik/"
    - user: root
    - group: root
    - require:
      - file: /etc/codesync.secret
      - file: webplatform-sources
      - file: piwik-perms

piwik-perms:
  file.directory:
    - name: /srv/webplatform/piwik
    - user: www-data
    - group: www-data
    - recurse:
      - user
      - group

/srv/webplatform/piwik/tmp/sessions:
  file.directory:
    - user: www-data
    - group: www-data
    - mode: 755
    - makedirs: True
    - require:
      - cmd: sync-piwik


# See also in vm.salt
/srv/webplatform/piwik/config/config.ini.php:
  file.managed:
    - source: salt://code/files/piwik/config.ini.php.jinja
    - template: jinja
    - user: www-data
    - group: www-data
    - mode: 644
    - require:
      - cmd: sync-piwik
