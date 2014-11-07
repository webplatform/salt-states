{%- set users = salt['pillar.get']('users', {}) %}
{% from "environment/_macros.sls" import install_bash_aliases %}

include:
  - groups
{% for username in users %}
  - users.{{ username }}
{% endfor %}

{% for username in users %}
{{ install_bash_aliases(username) }}

{% endfor %}

#  ---- UNSURE ARE BELOW ----
#  - users.jkomoros
#  - users.julee
#  - users.frozenice
#  - users.garbee
#  - users.pdsouza
#
# User ids #TODO:
# - 1005, shepazu
# - 1006, tguild
# - 1007, renoirb
# - 1008, jean-gui
# - 1009, vivien
# - 1010, darobin
# - 1011, tripu
# - 1150, estheban
# - 1151, laner
# - 1152
# - 1153
# - 1154
# - 1155
# - 1156
# - 1157
# - 1158
#
# - 1017: renoirb (MOVE to 1003)
# - 1018
# - 1019
# - 1020
# - 1021
# - 1022
# - 1023
# - 1024
# - 1025
