    {%- set dir = '/srv/webplatform/discuss' -%}
    {%- set tld   = salt['pillar.get']('infra:current:tld', 'webplatform.org') -%}
    {%- set level = salt['grains.get']('level', 'production') -%}
    {%- set smtp  = salt['pillar.get']('infra:hosts_entries:mail', 'mail.webplatform.org') -%}
    {%- set alpha_redis = salt['pillar.get']('infra:alpha_redis') -%}
    include:
      - code.prereq
      - users.app-user

    # salt notes git.clone /srv/webplatform/notes-server https://github.com/webplatform/annotation-service.git user="renoirb"
    clone-discuss:
      pkg.installed:
        - name: git
      git.latest:
        - name: https://github.com/discourse/discourse_docker.git
        - user: app-user
        - target: {{ dir }}
        - unless: test -f {{ dir }}/containers/app.yml
        - require:
          - file: {{ dir }}
          - pkg: git
      file.directory:
        - name: {{ dir }}
        - require:
          - file: webplatform-sources
        - user: app-user
        - group: www-data
        - recurse:
          - user
          - group

{{ dir }}/containers/app.yml:
  file.managed:
    - template: jinja
    - source: salt://code/files/discuss/app.yml.jinja
    - user: app-user
    - group: www-data
    - context:
        tld: {{ tld }}
        level: {{ level }}
        dir: {{ dir }}
        smtp_relay: {{ smtp }}
        alpha_redis: {{ alpha_redis }}

