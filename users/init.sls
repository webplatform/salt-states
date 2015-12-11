{%- set users = salt['pillar.get']('users', {}) %}

include:
  - groups
{% for username in users %}
  - .{{ username }}
{% endfor %}

# User ids:
# - 1005, shepazu
# - 1006, tguild
# - 1007, renoirb
# - 1008, jean-gui
# - 1009, vivien
# - 1010, robin
# - 1011, tripu
# - 1012, gerald
# - 1150, estheban
# - 1151, laner
# - 1152, justinlund

