include:
  - groups.w3t
  - groups.deployment

jean-gui:
  group.present:
    - gid: 1008
  user.present:
    - fullname: Jean-Guilhem Rouel <jean-gui@w3.org>
    - shell: /bin/bash
    - uid: 1008
    - gid: 10001
    - groups:
      - jean-gui
      - deployment
      - w3t
    - require:
      - group: deployment
      - group: w3t

jean-gui_keys:
  ssh_auth:
    - present
    - user: jean-gui
    - enc: ssh-rsa
    - require:
      - user: jean-gui
    - names:
      - AAAAB3NzaC1yc2EAAAADAQABAAABAQDq2OIsvtlK6YRtC42hWLNt2y1jH193trFH3xbCpRlxSvVG3kp4xiUo0VBh3dWQhZI31tNrqDxMWB8fJjcl0d8EvBts+CsmnJVy/PkwpbbkSakUHrpR+SQyr7IzDMpl7hSag/lyODjcHVq3rJOWCNUKm9uGtfu6lDO6Yy+t/hogvNLmANLiyAVj9EaCuFw4jsLXZHf10uM1iZqhnGVhwnkxJ0JvwhjVs5VV6EkpDDZWtSjsMY+95VWUH0ssfizITNzXSeVYsLi5mwG8TPtS4jLmblZEcb0ADRnTzfgUo2kQfi3vCZ7npMvgHv3UKC37VJQt1xmPWeSBv2t/HCBw/mJx jean-gui@barbossa
      - AAAAB3NzaC1yc2EAAAABIwAAAQEAwH45ObIU79BUyPNPb05eTwpXtKKvkUS+ygk9eieoOwDYdcZZhP/oDzL9DyWGM2XbGFTonP1ah4q9MlfwZqxJ1lMScUVD9r2KB4oGaB2DQMCPfgxZ6Pnp1DzvbtM2FBCb/2CZAVZEzIoI7J5KMwgY56aRKPaN6/QV4UFfUmo3tWCV3dIogo3B9+GfG1x0PoyrD8SYBJldTPtzi+6qv6QY8n5mU33DMfeiCmaMNz9rqxF0c4cLLgdYNTmF4aiDrMIyPAEp0mAqQs1WO7hVfOcnw2YayMu0I59AzO9B0TQmU2Wv2ArGXYc98xFWM4W9VMLWR5DYTKtbEdymGy4/CoThWQ== rouel@tarja
