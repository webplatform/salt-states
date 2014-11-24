include:
  - apache
  - php.mediawiki-apache
  - php

{% from "apache/module.sls" import a2mod %}
{{ a2mod('ssl') }}
{{ a2mod('rewrite') }}
