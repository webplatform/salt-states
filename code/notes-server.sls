include:
  - rsync.secret
  - code.prereq
  - code.certificates

# We do NOT rsync everything, especially what is in gitighore
# @salt-master-dest
rsync-hypothesis:
  cmd.run:
    - name: "rsync -a --no-perms --filter='dir-merge,-n /.gitignore' --password-file=/etc/codesync.secret codesync@salt::code/notes-server/repo/ /srv/webplatform/notes-server/"
    - group: deployment
{#    The following line prevents to sync only once. Unless we explicitly delete that file #}
    - unless: test -f /srv/webplatform/notes-server/h.ini
    - require:
      - file: /etc/codesync.secret
      - file: /srv/webplatform/notes-server
  file.directory:
    - name: /srv/webplatform/notes-server
    - require:
      - file: webplatform-sources
    - watch_in:
      - cmd: rsync-hypothesis
    - user: www-data
    - group: www-data
    - recurse:
      - user
      - group

/srv/webplatform/notes-server/h.ini:
  file.managed:
    - template: jinja
    - source: salt://code/files/notes-server/h.ini.jinja
    - user: www-data
    - group: www-data
    - context:
        elastic_endpoint: {{ salt['pillar.get']('infra:notes:elastic_endpoint', 'http://127.0.0.1:9200') }}
        hypothesis_port: {{ salt['pillar.get']('infra:notes:port', 8000) }}
        hypothesis_host: {{ salt['pillar.get']('infra:notes:host', '127.0.0.1') }}
        notes_url: {{ salt['pillar.get']('infra:notes:url', 'https://notes.webplatform.org') }}
        accounts_auth: {{ salt['pillar.get']('infra:accounts:auth', 'https://oauth.accounts.webplatform.org/v1/authorization') }}
        accounts_token: {{ salt['pillar.get']('infra:accounts:token', 'https://oauth.accounts.webplatform.org/v1/token') }}
        accounts_session: {{ salt['pillar.get']('infra:accounts:session', 'https://profile.accounts.webplatform.org/v1/session') }}
        accounts_session_read: {{ salt['pillar.get']('infra:accounts:session_read', 'https://profile.accounts.webplatform.org/v1/session/read') }}
        accounts_session_recover: {{ salt['pillar.get']('infra:accounts:session_recover', 'https://profile.accounts.webplatform.org/v1/session/recover') }}
        accounts_client_id: {{ salt['pillar.get']('accounts:notes:client_id', 'af626da2c9106504') }}
        accounts_client_secret: {{ salt['pillar.get']('accounts:notes:client_secret', '30b57cda3bb7f94beb132565e136b9965a58d86b151cd9e3c10b01e1651e72e2') }}
    - require:
      - file: /srv/webplatform/notes-server
      - cmd: rsync-hypothesis

