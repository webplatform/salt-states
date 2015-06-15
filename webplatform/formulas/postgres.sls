# So far, ONLY Discourse uses PostgreSQL
# ref: https://github.com/discourse/discourse/blob/master/docs/DEVELOPER-ADVANCED.md

include:
  - postgres

Ensure Discourse PostgreSQL dependencies are installed:
  pkg.installed:
    - pkgs:
      - postgresql-contrib-9.3
      - libpq-dev
      - postgresql-server-dev-9.3

