# TODO: Ensure volumes are created

#
# IMPORTANT: Do not forget the firewall ports
#              - TCP: 24007-24009 (24009 + number of bricks across all volumes)
#              - TCP/UDP: 111
#              - TCP: 38465-38467
#
# See:
#  - http://gluster.org/community/documentation/index.php/Gluster_3.2:_Installing_GlusterFS_from_Source
#  - http://www.gluster.org/community/documentation/index.php/QuickStart
#
# gluster volume create testimages storage1.dho.wpdn:/srv/storage/testimages
# gluster volume create wiki-images storage1.dho.wpdn:/srv/storage/wiki-images
# gluster volume start testimages
# gluster volume start wiki-images

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
