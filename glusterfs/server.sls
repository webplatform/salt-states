# TODO: Ensure volumes are created

# gluster volume start testimages
# gluster volume start wiki-images
# gluster volume create testimages storage1.dho.wpdn:/srv/storage/testimages
# gluster volume create wiki-images storage1.dho.wpdn:/srv/storage/wiki-images

glusterd:
  pkg:
    - installed
  service:
    - running
    - enable: True
    - require:
      - pkg: glusterd
  require:
    - cmd.run: glusterfs-ppa
