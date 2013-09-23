renoirb:
  group.present:
    - gid: 1017
  user.present:
    - fullname: Renoir Boulanger <renoir@w3.org>
    - workphone: +1514 560-9341
    - shell: /bin/bash
    - uid: 1017
    - gid: 10001
    - groups:
      - renoirb
      - ops
      - deployment
    - require:
      - group: ops
      - group: deployment

/home/renoirb/.screenrc:
  file.managed:
    - user: renoirb
    - group: deployment
    - mode: 640
    - source: salt://environment/files/screenrc
    - require:
      - user: renoirb

{% if grains['host'] == 'deployment' %}
/home/renoirb/.my.cnf:
  file.managed:
    - user: renoirb
    - group: deployment
    - mode: 640
    - source: salt://environment/my.cnf
    - require:
      - user: renoirb
{% endif %}

renoirb_keys:
  ssh_auth:
    - present
    - user: renoirb
    - enc: ssh-rsa
    - require:
      - user: renoirb
    - names:
      - AAAAB3NzaC1yc2EAAAADAQABAAABAQC3yWFgjwICPb8kQdkO8OX228tGnRLzCvEV74QccCIGwZ3KvXzN9RDRdUZ7fr5sGhwx5s7WQbXkLwOtAxyAUPB1K2DJnJiK/99n4lEjR3vUZN5p7ni7LsrwuoD0A7fF3PlBILYI294xaI/nikJFP14MKgX2TZcEBfY6bVeNmIuthlimKsfpIA2KtKm56zurMjVfjPCQYmcrThs0Wa4ArlAal8IlwPcLAJrjWaFfqjJlIA+PwclXj1xbRLhALkwNmFwkTsea1oT70ydFAeWH+Ui8+bTpjtEIthDVL1BkQ8mMhbrRXa/rVFU72ENc7iY2pknKSBA0hlRRumG8gYKAAhh1 hello@renoirboulanger.com
      - AAAAB3NzaC1yc2EAAAADAQABAAABAQDRLNSRLXV2C72DN1ikaAkZf94IliL0DOU4TomINFrdHMR+bvftHtvpEnPRo2LUxNNJDg3TIJKxVQ+oZ58lsPAqrS+nEU3ujq8vCkh9C+qWfPEZmjX4JJTX9LusEVahziPFEcvEcD0FHHsLuQhAmyD2EauKZnlSFmsaRKX9+bFSlKeYuZZigpAsyfsWcVlaXSNR1UsrBROkF/3/lrlgG6sq8gN4W1/kvN9lbIwky2RFNKxOJL0VomLWWl/DBm0XEsf8lX+a34bLJMLGXyMlgIu+3grNGD6I1TcdOx24vvxnWQOE5uKIH8YdLyF566CmlsvhB825zETxYbWb1wwQ1T67 renoirb@vm.renoirboulanger.com
      - AAAAB3NzaC1yc2EAAAADAQABAAABAQDlrp/7uNPxICppMUD6BSpQm8Xzjo4EUJHqZL7k5nEdNe0GqSOOw5W1UxAtuBx69PukWAfOtrbXgsaTha7gZSX7lLi34UF+Lp/b/mz2FXOl/d4cVNDjfaBeSptV5rDoohyuR15WqrussA3UPqris5jsuyUgK/+xnQHvbgSvQ3yWU9Rfy4lnlGpznPs1G3uF9JY1LZLb56brOOfPPSNtO/mYjaxvniqWZI6oTtEMM9XM8tDaZNWA3s08riBslj0EWSzcGOBhQ0oHMVGElgwWNvSYRVyb1xjW9raaFtKdfsK2nKTGUJ6wIx1+V4jSOJWpmq9+y7jJmNHDijpAPTO4NvZz renoirb@jay.w3.org
