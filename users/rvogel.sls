rvogel:
  group.present:
    - gid: 1008
  user.present:
    - shell: /bin/bash
    - uid: 1008
    - gid: 10001
    - groups:
      - rvogel
      - ops
      - deployment
    - require:
      - group: ops
      - group: deployment

AAAAB3NzaC1yc2EAAAADAQABAAABAQC++UwQL9xdxFAT0sjlB4tmJS9IC5lxyZNbhvPQueo0H2rGtKW4LDq0mVXsGvxcCVfhqlgsORO7zontfFuPNZghfTvPcb4rJlg1OxTJy+fhJAzsKQkBCdVbSif5GN93TOBplVxfuTrbtsHASTeIQplwouoFLIMeF3g18JZ0tlTrPf7gWniGfHGUZ7UoCmX3r0eb1c7UHLz7OHqNOEykcl2BRaOlXIwNPRuKtuM1wh/9vic7Ao6P90JUdSiBkA5O2itxXR6oszqc7p6JI+LdQaAACVR+SwbY0fb3KaTfMJacg5UeBDDK+nCb7yLyFlH9mfV2cZ46A5PKVNS56/iWw2oT:
  ssh_auth:
    - present
    - user: rvogel
    - enc: ssh-rsa
    - comment: vogel@hallowelt.biz
    - require:
      - user: rvogel
