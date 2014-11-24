include:
  - rsync.secret
  - code.prereq
  - piwik.config

# @salt-master-dest
sync-piwik:
  cmd.run:
    - name: "rsync -a --exclude 'tmp' --exclude '.git' --exclude '.svn' --delete --no-perms --password-file=/etc/codesync.secret codesync@salt::code/piwik/repo/ /srv/webplatform/piwik/"
    - user: root
    - group: root
    - require:
      - file: /etc/codesync.secret
      - file: webplatform-sources

piwik-perms:
  file.directory:
    - name: /srv/webplatform/piwik
    - user: www-data
    - group: www-data
    - wait:
      - pkg: sync-piwik
    - recurse:
      - user
      - group

{% if grains['nodename'] == 'salt' %}
# See also in code.piwik.config config patch
/srv/code/piwik/repo/config/config.ini.php:
  file.managed:
    - template: jinja
    - source: salt://piwik/files/config.ini.php.jinja
{% endif %}
