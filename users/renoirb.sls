{%- set names = ['id_pwless','id_ecdsa'] -%}
include:
  - groups.w3t
  - groups.deployment
  - groups.ops

renoirb:
  group.present:
    - gid: 1007
  user.present:
    - fullname: Renoir Boulanger <renoir@w3.org>
    - workphone: +1514 560-9341
    - shell: /bin/bash
    - uid: 1007
    - gid: 10001
    - groups:
      - renoirb
      - ops
      - deployment
      - w3t
    - require:
      - group: ops
      - group: deployment
      - group: w3t

/home/renoirb/.gitconfig:
  file.managed:
    - user: renoirb
    - group: renoirb
    - mode: 640
    - source: salt://users/files/renoirb/gitconfig
    - require:
      - user: renoirb

/home/renoirb/.vimrc:
  file.managed:
    - user: renoirb
    - group: renoirb
    - source: salt://users/files/renoirb/vimrc

{% if grains['nodename'] == 'salt' %}
preferences:
  pkg.installed:
    - names:
      - tig
      - screen
      - mtail

/home/renoirb/.mtailrc:
  file.managed:
    - user: renoirb
    - group: renoirb
    - source: salt://users/files/renoirb/mtailrc

/home/renoirb/.ssh/config:
  file.managed:
    - user: renoirb
    - group: renoirb
    - mode: 600
    - source: salt://users/files/renoirb/sshconfig
    - require:
      - ssh_auth: renoirb_keys

##
## To get keys, try with command:
##
##     salt salt pillar.get sshkeys:renoirb:id_ecdsa:private
##
{% for key_name in names %}
/home/renoirb/.ssh/{{ key_name }}:
  file.managed:
    - contents_pillar: sshkeys:renoirb:{{ key_name }}:private
    - user: renoirb
    - group: renoirb
    - mode: 0600
    - require:
      - ssh_auth: renoirb_keys

/home/renoirb/.ssh/{{ key_name }}.pub:
  file.managed:
    - contents_pillar: sshkeys:renoirb:{{ key_name }}:public
    - user: renoirb
    - group: renoirb
    - mode: 0600
    - require:
      - ssh_auth: renoirb_keys
{% endfor %}

{% endif %}

renoirb_keys:
  ssh_auth.present:
    - user: renoirb
    - enc: ssh-rsa
    - require:
      - user: renoirb
    - names:
      - AAAAB3NzaC1yc2EAAAADAQABAAABAQC3yWFgjwICPb8kQdkO8OX228tGnRLzCvEV74QccCIGwZ3KvXzN9RDRdUZ7fr5sGhwx5s7WQbXkLwOtAxyAUPB1K2DJnJiK/99n4lEjR3vUZN5p7ni7LsrwuoD0A7fF3PlBILYI294xaI/nikJFP14MKgX2TZcEBfY6bVeNmIuthlimKsfpIA2KtKm56zurMjVfjPCQYmcrThs0Wa4ArlAal8IlwPcLAJrjWaFfqjJlIA+PwclXj1xbRLhALkwNmFwkTsea1oT70ydFAeWH+Ui8+bTpjtEIthDVL1BkQ8mMhbrRXa/rVFU72ENc7iY2pknKSBA0hlRRumG8gYKAAhh1 hello@renoirboulanger.com
      - AAAAB3NzaC1yc2EAAAADAQABAAABAQDRLNSRLXV2C72DN1ikaAkZf94IliL0DOU4TomINFrdHMR+bvftHtvpEnPRo2LUxNNJDg3TIJKxVQ+oZ58lsPAqrS+nEU3ujq8vCkh9C+qWfPEZmjX4JJTX9LusEVahziPFEcvEcD0FHHsLuQhAmyD2EauKZnlSFmsaRKX9+bFSlKeYuZZigpAsyfsWcVlaXSNR1UsrBROkF/3/lrlgG6sq8gN4W1/kvN9lbIwky2RFNKxOJL0VomLWWl/DBm0XEsf8lX+a34bLJMLGXyMlgIu+3grNGD6I1TcdOx24vvxnWQOE5uKIH8YdLyF566CmlsvhB825zETxYbWb1wwQ1T67 renoirb@vm.renoirboulanger.com
      - AAAAB3NzaC1yc2EAAAADAQABAAABAQDlrp/7uNPxICppMUD6BSpQm8Xzjo4EUJHqZL7k5nEdNe0GqSOOw5W1UxAtuBx69PukWAfOtrbXgsaTha7gZSX7lLi34UF+Lp/b/mz2FXOl/d4cVNDjfaBeSptV5rDoohyuR15WqrussA3UPqris5jsuyUgK/+xnQHvbgSvQ3yWU9Rfy4lnlGpznPs1G3uF9JY1LZLb56brOOfPPSNtO/mYjaxvniqWZI6oTtEMM9XM8tDaZNWA3s08riBslj0EWSzcGOBhQ0oHMVGElgwWNvSYRVyb1xjW9raaFtKdfsK2nKTGUJ6wIx1+V4jSOJWpmq9+y7jJmNHDijpAPTO4NvZz renoirb@jay.w3.org

AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBNTfCgTMiz9+cuhrVl3/ZYMgs/nyYPlson0anNX17HHNqgB1ioItZqXonuviXOtE3tYIKxtjirzg/PK8QcELeBc=:
  ssh_auth.present:
    - user: renoirb
    - enc: ecdsa-sha2-nistp256
    - require:
      - user: renoirb
    - comment: renoirb@salt.webplatform.org

AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBNJLx46jc9WkfygwqmP4PpqjFg53OA5uavu3LJnzIEsptIpi0j4OoyS92dxoXMeoUr7FKqEQ1iJ+032Nksm4Msw=:
  ssh_auth.present:
    - user: renoirb
    - enc: ecdsa-sha2-nistp256
    - require:
      - user: renoirb
    - comment: renoirb@salt.webplatformstaging.org

