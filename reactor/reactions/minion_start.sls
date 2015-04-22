{#
 # Sync grains, modules and al.
 #
 # This reactor isn’t run as a state,
 # make sure this file is called from /etc/master.d/reactor.conf
 # as a salt://salt/reactor/reaction/foo.sls instead.
 #}

sync_all:
  local.saltutil.sync_all:
    - tgt: {{ data['id'] }}
    - ret: syslog
