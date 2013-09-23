julee:
  group.present:
    - gid: 1016
  user.present:
    - shell: /bin/bash
    - uid: 1016
    - gid: 10001
    - groups:
      - julee
      - ops
      - deployment
    - require:
      - group: ops
      - group: deployment

julee_keys:
  ssh_auth:
    - present
    - user: julee
    - enc: ssh-rsa
    - require:
      - user: julee
    - names:
      - AAAAB3NzaC1yc2EAAAADAQABAAABAQCxzwr8EyJAsKgL4F3tCi3SWMxwoAATHd/jaZM28/TK/Ayuz3EW1nURAFOFbPsofWEhBxToL/KXIdO9o+m+s57MZDrtnvCRmlspJIaYnz6LcWWRvFrGTQ9YpD+X7AUVQkNH+v3LYlF9KQMZgTDqVdt8smdTHL7n9ducEiszGOzxHRjtCamUXHQmuyp2kKVM1llpsXlBNJmMG2p2NsPRdV5zokrAUYQ1zeW9A6kDAhDuaTzsoiTRU6LdhS+f7GwUVP4PNxQ7QUm8ug8pvWLVC+JHCXtzeYuQ0EQNpZbvA2zxdOIU+K5xqCm/HifRLkFKbZNe+aBFD0ZBKCHym2wPyfN1 julee@adobe.com
