shepazu:
  group.present:
    - gid: 1002
  user.present:
    - fullname: Doug Schepers
    - shell: /bin/bash
    - uid: 1002
    - gid: 10001
    - groups:
      - shepazu
      - ops
      - deployment

shepazu_keys:
  ssh_auth:
    - present
    - user: shepazu
    - enc: ssh-rsa
    - require:
      - user: shepazu
    - names:
      - AAAAB3NzaC1yc2EAAAADAQABAAABAQC3XHXlQiIzF9QdvHs4Ybe8vXv4sfY6tdhpMlYDi7mD9ohPEd77xAdKo3ocKXWJ4Gjv3bf48s02YTqPCtCWMoTZKgdDsAbMcJPWnKOyawTjsTO2/EviXV+cGR3FY/HKgebozkAjxH7Ldo39PS0Xwx2VfaTcIJwzX3jDNNFgCCMwgMwRcwUC4DjkAMX5YLTn4n2BuEzAvxzlDijLI2CXAiCrtdkwOwdMqam8+4olKeFsn2YBTQC7PO3xoQ1FrUPjmo7JzGlyecHOxYDY5skE28bbwy6Eb6j9Ahxt2dYNh3cocLh4foRYPuebwDTCtOltGzHKb5RvT1WaeJ9SZLEzRtAB shepazu@unknown109adde84c2e default