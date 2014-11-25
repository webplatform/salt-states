{#
 # Upgrade packages
 #
 # This reactor isn’t run as a state,
 # make sure this file is called from /etc/master.d/reactor.conf
 # as a salt://salt/reactor/reaction/foo.sls instead.
 #
 # data looks like:
 #
 #     {id: 'foo', act: 'accept'};
 #
 # act key can be one of: [accept,pend,reject]
 #
 #}
{% if data['act'] == 'accept' %}
upgrade_pkgs:
  local.pkg.upgrade:
    - tgt: {{ data['id'] }}
    - ret: syslog

send_ip_addrs:
  local.mine.send:
    - tgt: '*'
    - arg: 
      - 'network.ip_addrs'
    - ret: syslog
{% endif %}
