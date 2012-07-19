glusterfs-ppa:
  cmd.run:
    - name: "add-apt-repository ppa:semiosis/glusterfs-3.3 && apt-get update"
    - unless: apt-key list | grep '1024R/774BAC4D'

glusterfs-client:
  pkg:
    - installed
  require:
    - cmd.run: glusterfs-ppa
