include:
  - rsync.secret
  - code.prereq

/srv/webplatform/blog/robots.txt:
  file.managed:
    - source: salt://code/files/blog/robots.txt
    - user: www-data
    - group: www-data

# @salt-master-dest
rsync-blog:
  cmd.run:
    - name: "rsync -a  --exclude '.git' --delete --no-perms --password-file=/etc/codesync.secret codesync@salt::code/blog/repo/ /srv/webplatform/blog/"
    - user: root
    - group: root
    - require:
      - file: /etc/codesync.secret
      - file: webplatform-sources
  file.directory:
    - name: /srv/webplatform/blog
    - user: www-data
    - group: www-data
    - file_mode: 644
    - dir_mode: 755
    - recurse:
      - user
      - group
      - mode

/srv/webplatform/blog/local.php:
  file.managed:
    - source: salt://code/files/blog/local.php.jinja
    - template: jinja
    - user: www-data
    - group: www-data
    - require:
      - cmd: rsync-blog
