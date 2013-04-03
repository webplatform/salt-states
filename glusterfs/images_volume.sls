manage_images_auth_allow:
  cmd.run:
    - name: gluster volume set wiki-images auth.allow {{ pillar['volume_auth_allow']['wiki-images'] }}
    - unless: "gluster volume info wiki-images | grep 'auth.allow' | grep '{{ pillar['volume_auth_allow']['wiki-images'] }}"
    - user: root
    - group: root

manage_testimages_auth_allow:
  cmd.run:
    - name: gluster volume set testimages auth.allow {{ pillar['volume_auth_allow']['wiki-images'] }}
    - unless: "gluster volume info testimages | grep 'auth.allow' | grep '{{ pillar['volume_auth_allow']['wiki-images'] }}"
    - user: root
    - group: root

/srv/storage/wiki-images:
  file.directory:
    - require:
      - mount: /srv/storage

/srv/storage/testimages:
  file.directory:
    - require:
      - mount: /srv/storage

/mnt/storage/wiki-images:
  file.directory

/mnt/storage/testimages:
  file.directory
