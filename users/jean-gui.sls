jean-gui:
  group.present:
    - gid: 1020
  user.present:
    - fullname: Jean-Guilhem Rouel <jean-gui@w3.org>
    - shell: /bin/bash
    - uid: 1020
    - gid: 10001
    - groups:
      - jean-gui
      - ops
      - deployment

jean-gui_keys:
  ssh_auth:
    - present
    - user: jean-gui
    - enc: ssh-rsa
    - require:
      - user: jean-gui
    - names:
      - AAAAB3NzaC1yc2EAAAADAQABAAABAQDq2OIsvtlK6YRtC42hWLNt2y1jH193trFH3xbCpRlxSvVG3kp4xiUo0VBh3dWQhZI31tNrqDxMWB8fJjcl0d8EvBts+CsmnJVy/PkwpbbkSakUHrpR+SQyr7IzDMpl7hSag/lyODjcHVq3rJOWCNUKm9uGtfu6lDO6Yy+t/hogvNLmANLiyAVj9EaCuFw4jsLXZHf10uM1iZqhnGVhwnkxJ0JvwhjVs5VV6EkpDDZWtSjsMY+95VWUH0ssfizITNzXSeVYsLi5mwG8TPtS4jLmblZEcb0ADRnTzfgUo2kQfi3vCZ7npMvgHv3UKC37VJQt1xmPWeSBv2t/HCBw/mJx jean-gui@barbossa
