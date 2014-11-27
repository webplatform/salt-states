{%- set dabbletConfig = salt['pillar.get']('accounts:github:dabblet', {}) -%}

include:
  - code.prereq
  - rsync.secret

# @salt-master-dest
dabblet-rsync:
  cmd:
    - run
    - name: "rsync -a --exclude '.git' --delete --no-perms --password-file=/etc/codesync.secret codesync@salt::code/dabblet/repo/ /srv/webplatform/dabblet/"
    - user: root
    - group: root
    - require:
      - file: /etc/codesync.secret
      - file: webplatform-sources
      - file: /srv/webplatform/dabblet

/srv/webplatform/dabblet/keys.php:
  file.managed:
    - source: salt://code/files/dabblet/keys.php.jinja
    - template: jinja
    - context:
        client_id: {{ dabbletConfig['client_id']|default('') }}
        client_secret: {{ dabbletConfig['client_secret']|default('') }}
        long_term_token: {{ dabbletConfig['long_term_token']|default('') }}
    - require:
      - cmd: dabblet-rsync

/srv/webplatform/dabblet:
  file.directory:
    - mode: 755
    - makedirs: True
    - user: www-data
    - group: www-data
