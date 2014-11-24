include:
  - apache
  - php.mediawiki-apache
  - php

{% from "apache/module.sls" import a2mod %}
{{ a2mod('ssl') }}
{{ a2mod('rewrite') }}

# Initial install of MediaWiki via states
{% for slot in ['wpwiki','wptestwiki'] %}
/srv/webplatform/wiki/{{ slot }}/cache:
  file.directory:
    - mode: 755
    - makedirs: True
    - user: www-data
    - group: www-data
    - recurse:
      - user
      - group
{% endfor %}
