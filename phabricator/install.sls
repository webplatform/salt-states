{%- set phabricatorDependencies = ['libphutil','arcanist','phabricator'] -%}

{% from "phabricator/_macros.sls" import phabricator_component %}

{%- for component in phabricatorDependencies %}
{{ phabricator_component(component) }}
{%- endfor %}

/srv/webplatform/source/phabricator/conf/local/local.json:
  file.managed:
    - source: salt://phabricator/files/conf/local.json.jinja
    - template: jinja
    - require:
      - git: clone-phabricator

/srv/webplatform/source/phabricator/resources/chatbot/wpdbot.json:
  file.managed:
    - source: salt://phabricator/files/conf/wpdbot.json.jinja
    - template: jinja
    - require:
      - git: clone-phabricator

# See How WMF configures it
# https://github.com/wikimedia/operations-puppet/blob/production/modules/phabricator/manifests/init.pp
#
# Launching bot
# ./bin/phd launch phabricatorbot /srv/webplatform/source/phabricator/resources/chatbot/wpdbot.json
#
# Launching services
# bin/phd start

phabricator-deps:
  pkg.installed:
    - names:
      - python-pygments
      - php5-mailparse
      - php5-curl
      - php5-json
