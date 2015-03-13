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
# https://github.com/wikimedia/operations-puppet/blob/production/modules/phabricator/data/fixed_settings.yaml
#
# Launching bot
# ./bin/phd launch phabricatorbot /srv/webplatform/source/phabricator/resources/chatbot/wpdbot.json
#
# Launching services
# bin/phd start
#


# Disable application (to test how to setup correctly)
#
# phabricator.uninstalled-applications:
#   PhabricatorApplicationPhriction: true
#   PhabricatorApplicationDiviner: true
#
# ref: https://phabricator.wikimedia.org/T193
#      https://source.webplatform.org/config/edit/phabricator.uninstalled-applications/
#


# Diffusion
#
# groupadd -r phd
# useradd -r -g phd -s /bin/bash -d /srv/webplatform/source/phabricator phd
# useradd -r -s /bin/bash -d /srv/webplatform/source/phabricator git
#
# in /etc/sudoers
#
# git ALL=(phd) SETENV: NOPASSWD: /usr/bin/git-upload-pack, /usr/bin/git-receive-pack, git
#
# ref: https://secure.phabricator.com/book/phabricator/article/diffusion_hosting/
#
# in vipw -s
# git:NP:16455::::::
#
# usermod -a -G www-data phd
# chown -R phd:phd /var/tmp/phd/
# chmod g+w /var/tmp/phd/pid
#


# And those options are available:
#
# translation.override:
#   'Execute Query': 'Search'
#   'Maniphest Task': 'Task'
#   'Pholio Mock': 'Mockup'
#   'Real Name': 'Also Known As'
#
# # We don't host local docs or use the wiki :)
# phabricator.uninstalled-applications:
#   PhabricatorApplicationPhriction: true
#   PhabricatorApplicationDiviner: true
#

phabricator-deps:
  pkg.installed:
    - names:
      - python-pygments
      - php5-curl
      - php5-json


