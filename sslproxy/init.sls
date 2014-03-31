include:
  - sslproxy.nginx

openssl-installed:
  pkg.installed:
    - name: openssl
    - require_in:
      - file: /etc/ssl/webplatform

/var/www/index.html:
  file.managed:
    - source: salt://sslproxy/files/index.html

/etc/ssl/webplatform:
  file.directory:
    - user: root
    - group: root
    - dir_mode: 710
    - file_mode: 644
    - require:
      - pkg: openssl-installed

redis-server:
  pkg.installed

oauthd-bleeding-requirements:
  cmd.run:
    - name: npm install -g coffee-script grunt-cli forever
    - unless: test -d /usr/lib/node_modules/grunt-cli
    # Reminder, to test folder existence: test -d /usr/lib && echo 'Folder exist' || echo 'Folder doesnt'

{#
 # Example certificates Pillar data
 #
 # certificates:
 #   roots:
 #     startssl:
 #       ca:
 #         name: startssl.ca.pem
 #         contents: |
 #            -----BEGIN CERTIFICATE-----
 #            ...
 #            -----BEGIN CERTIFICATE-----
 #       bundle:
 #         name: startssl.bundle.pem
 #         contents: |
 #            -----BEGIN CERTIFICATE-----
 #            ...
 #            -----BEGIN CERTIFICATE-----
 #   privatekeys:
 #     201403:
 #       name: webplatform.key
 #       contents: |
 #            -----BEGIN PRIVATE KEY-----
 #            ...
 #            -----END PRIVATE KEY-----
 #   certificates:
 #     ssl_webplatform_org:
 #       name: webplatform.crt
 #       provider: startssl
 #       privatekey: 201403
 #       contents: |
 #           -----BEGIN CERTIFICATE-----
 #           ...
 #           -----END CERTIFICATE-----
 #}
{% set bucketNames = ['roots','privatekeys','certificates'] %}

{% for loopItem in bucketNames %}
{% for bk, bucket in salt['pillar.get']('certificates:%s' % loopItem).items() %}
{% if loopItem == 'roots' %}
{#
  ROOT CERTIFICATES LOOP
#}
{% for rk, root in bucket.items() %}
/etc/ssl/webplatform/{{ root.get('name') }}:
  file.managed:
    - contents: |-
        {{ root.get('contents')|indent(8) }}
    - file_mode: 644
{% endfor %}
{% else %}
{#
  Other type of files, most likely private.
#}
/etc/ssl/webplatform/{{ bucket.get('name') }}:
  file.managed:
    - contents: |-
        {{ bucket.get('contents')|indent(8) }}
    - file_mode: 640
{% endif %}
    - user: root
    - group: root
    - require:
      - file: /etc/ssl/webplatform
{% endfor %}{# end for bk, bucket #}
{% endfor %}{# end loopItem in bucketNames #}
