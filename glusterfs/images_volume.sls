{% set list = ','.join(salt['pillar.get']('infra:storage:allow_app_servers')) %}

manage_images_auth_allow:
  cmd.run:
    - name: gluster volume set wiki-images auth.allow {{ list }}
    - unless: "gluster volume info wiki-images | grep 'auth.allow' | grep '{{ list }}'"
    - user: root
    - group: root

manage_testimages_auth_allow:
  cmd.run:
    - name: gluster volume set testimages auth.allow {{ list }}
    - unless: "gluster volume info testimages | grep 'auth.allow' | grep '{{ list }}'"
    - user: root
    - group: root

/srv/storage/wiki-images:
  file.directory:
    - user: www-data
    - group: www-data
    - require:
      - mount: /srv/storage

/srv/storage/testimages:
  file.directory:
    - user: www-data
    - group: www-data
    - require:
      - mount: /srv/storage

/mnt/storage/wiki-images:
  file.directory

/mnt/storage/testimages:
  file.directory
