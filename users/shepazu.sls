shepazu:
  group.present:
    - gid: 1002
  user.present:
    - shell: /bin/bash
    - uid: 1002
    - gid: 10001
    - groups:
      - ops
      - shepazu
    - require:
      - group: shepazu
      - group: ops
      - group: deployment

shepazu_keys:
  ssh_auth:
    - present
    - user: shepazu
    - enc: ssh-rsa
    - require:
      - user: shepazu
    - names:
      - AAAAB3NzaC1yc2EAAAADAQABAAABAQC3XHXlQiIzF9QdvHs4Ybe8vXv4sfY6tdhpMlYDi7mD9ohPEd77xAdKo3ocKXWJ4Gjv3bf48s02YTqPCtCWMoTZKgdDsAbMcJPWnKOyawTjsTO2/EviXV+cGR3FY/HKgebozkAjxH7Ldo39PS0Xwx2VfaTcIJwzX3jDNNFgCCMwgMwRcwUC4DjkAMX5YLTn4n2BuEzAvxzlDijLI2CXAiCrtdkwOwdMqam8+4olKeFsn2YBTQC7PO3xoQ1FrUPjmo7JzGlyecHOxYDY5skE28bbwy6Eb6j9Ahxt2dYNh3cocLh4foRYPuebwDTCtOltGzHKb5RvT1WaeJ9SZLEzRtAB shepazu@unknown109adde84c2e
      - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDhull02mfjHWnCJjzBcDH25odEYue0a6bkKM1woyFWvl8KdUSzlLbhD3/8itxXcDC185e+rKBgIza1lMgB0dMhc+dv5Ph0OshX4QaYeQHSWsa4dwIdZP41NoHTppFcPJNLg/CreJC0no/TQmXQ/i6P3Ne7QQYJh/YKu9kM1UB0+LuNhnB9UDslDIZyEGKynqeVqdLgu7rRCqcBG/ldY439nwDI4QKxGw10qafKYyN196volv5BD5K6GAvHRv5FGf+yWDJ2vWsZWqvXraoZP/gEaWawVC5ddp4eg/o+bx91mIkHJTy4uGquCy/vTE3ZZAf1XX6ZZovpNaoCh17TtU63 shepazu@unknown109adde84c2e
