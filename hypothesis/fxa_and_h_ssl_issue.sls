{%- set auth_server_ip = salt['pillar.get']('infra:auth-server:auth:host') -%}
{%- set tld = salt['pillar.get']('infra:current:tld', 'webplatform.org') -%}

#
# After a few days of debugging, on a problem with the annotation-server and Python and SSL certificates
# this should make accounts server to have no other NGINX vhost except the private ones.
#

include:
  - hosts

superseed accounts IP addr to private network:
  file.append:
    - name: /etc/hosts
    - order: last
    - text: |
        {{ auth_server_ip }} api.accounts.{{ tld }}
        {{ auth_server_ip }} oauth.accounts.{{ tld }}
        {{ auth_server_ip }} profile.accounts.{{ tld }}

