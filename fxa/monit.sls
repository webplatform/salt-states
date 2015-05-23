{%- set infra_pillar = salt['pillar.get']('infra:auth-server') -%}
{%- set svc = ['profile', 'content', 'auth', 'oauth'] -%}
{%- set svc_user = 'webapps' -%}
{%- set svc_group = 'webapps' -%}

#
# Do not include fxa here, we can use monit to check if auth-server is responding
# which will be a useful check to do from a NGINX frontend server.
# ... but with current setup, we cannot do that yet.
#

include:
  - mmonit

{% for service in svc %}
/etc/monit/conf.d/fxa-{{ service }}.conf:
  file.managed:
    - source: salt://fxa/files/monit.{{ service }}.jinja
    - template: jinja
    - context:
        infra_pillar: {{ infra_pillar }}
        tld: {{ salt['pillar.get']('infra:current:tld', 'webplatform.org') }}
    - require:
      - pkg: monit
    - require_in:
      - service: monit
{% endfor %}

/usr/local/bin/profile-check.sh:
  file.managed:
    - source: salt://fxa/files/profile-check.sh.jinja
    - template: jinja
    - user: {{ svc_user }}
    - group: {{ svc_group }}
    - mode: 755
    - context:
        infra_pillar: {{ infra_pillar }}
    - require_in:
      - file: /etc/monit/conf.d/fxa-profile.conf

