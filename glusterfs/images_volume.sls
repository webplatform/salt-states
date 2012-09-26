manage_images_auth_allow:
  cmd.run:
    - name: gluster volume set images auth.allow {{ pillar['volume_auth_allow']['images'] }}
    - unless: "gluster volume info images | grep 'auth.allow' | grep '{{ pillar['volume_auth_allow']['images'] }}"
    - user: root
    - group: root

manage_testimages_auth_allow:
  cmd.run:
    - name: gluster volume set testimages auth.allow {{ pillar['volume_auth_allow']['images'] }}
    - unless: "gluster volume info testimages | grep 'auth.allow' | grep '{{ pillar['volume_auth_allow']['images'] }}"
    - user: root
    - group: root

/srv/storage/images:
  file.directory:
    - require:
      - mount: /srv/storage

/srv/storage/testimages:
  file.directory:
    - require:
      - mount: /srv/storage
