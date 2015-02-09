include:
  - rsync.secret
  - code.prereq
  - code.certificates
  - users.app-user

# @salt-master-dest
sync-hypothesis-dists:
  cmd.run:
    - name: rsync -a --no-perms --delete --password-file=/etc/codesync.secret codesync@salt::code/notes-server/dists/ /srv/webplatform/appshomedir/dists/notes-server/
    - require:
      - file: /etc/codesync.secret
      - file: /srv/webplatform/appshomedir/dists/notes-server
      - file: webplatform-sources
  file.directory:
    - name: /srv/webplatform/appshomedir/dists/notes-server
    - user: app-user
    - group: www-data
    - makedirs: True
    - require:
      - file: /srv/webplatform/appshomedir
      - user: app-user
    - recurse:
      - user
      - group

# salt notes git.clone /srv/webplatform/notes-server https://github.com/webplatform/annotation-service.git user="renoirb"
clone-hypothesis:
  pkg.installed:
    - name: git
  git.latest:
    - name: https://github.com/webplatform/annotation-service.git
    - user: app-user
    - target: /srv/webplatform/notes-server
    - unless: test -f /srv/webplatform/notes-server/h.ini
    - require:
      - file: /srv/webplatform/notes-server
      - pkg: git
  file.directory:
    - name: /srv/webplatform/notes-server
    - require:
      - file: webplatform-sources
    - user: app-user
    - group: www-data
    - recurse:
      - user
      - group

/srv/webplatform/notes-server/h.ini:
  file.managed:
    - template: jinja
    - source: salt://code/files/notes-server/h.ini.jinja
    - user: app-user
    - group: www-data
    - context:
        ## Expected keys: public_url, port, host, elastic_endpoint, sender_email, sender_relay
        notes_server_pillar: {{ salt['pillar.get']('infra:notes-server') }}
        ## Expected keys: auth, token, session, session_read, session_recover
        auth_server_endpoints: {{ salt['pillar.get']('infra:auth-server:endpoints') }}
        ## Expected keys: auth_client_id, auth_client_secret, secret
        notes_secrets_pillar: {{ salt['pillar.get']('accounts:notes-server') }}
    - require:
      - git: clone-hypothesis

/srv/webplatform/notes-server/service.sh:
  file.managed:
    - source: salt://code/files/notes-server/service.sh
    - mode: 755
    - user: app-user
    - group: www-data
    - require:
      - file: /srv/webplatform/notes-server/h.ini

