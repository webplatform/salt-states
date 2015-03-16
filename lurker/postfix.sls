include:
  - lurker
  - mail.mailhub

Adjust postfix master.cf to use lurker:
  file.append:
    - name: /etc/postfix/master.cf
    - require:
      - pkg: lurker
      - sls: mail.mailhub
    - text: |
        lurker unix - n n - - pipe
          user=www-data:www-data argv=/usr/bin/lurker-index -l notices-all -m

