# #TODO:
#  - Make sure webplatform.key is 640

openssl-installed:
  pkg.installed:
    - name: openssl
    - require_in:
      - file: /etc/ssl/webplatform

/etc/ssl/webplatform:
  file.directory:
    - user: root
    - group: root
    - dir_mode: 710
    - file_mode: 644
    - require:
      - pkg: openssl-installed

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

/etc/ssl/webplatform/webplatform.pem:
  cmd:
    - run
    - name: files=("webplatform.crt" "startssl.sub.class1.server.ca.pem" "startssl.ca.pem") && for i in ${files[@]} ; do $(cat $i >> webplatform.pem && echo "" >> webplatform.pem) ; done
    - cwd: /etc/ssl/webplatform/
    - creates: /etc/ssl/webplatform/webplatform.pem
    - require:
      - file: /etc/ssl/webplatform/webplatform.crt
      - file: /etc/ssl/webplatform/startssl.ca.pem
      - file: /etc/ssl/webplatform/startssl.sub.class1.server.ca.pem
  file:
    - exists
