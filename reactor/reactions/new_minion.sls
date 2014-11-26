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
 # `cmd.foo` and `local.foo` are aliases. In other words `cmd.pkg.upgrade`
 # is the same as `local.pkg.upgrade`.
 #}
{% if data['act'] == 'accept' %}
upgrade_pkgs:
  cmd.pkg.upgrade:
    - tgt: {{ data['id'] }}
    - ret: syslog

send_ip_addrs:
  cmd.mine.send:
    - tgt: '*'
    - arg: 
      - 'network.ip_addrs'
    - ret: syslog
{% endif %}
{% if data['act'] == 'reject' %}
delete_ip_addrs:
  cmd.mine.delete:
    - tgt: '*'
    - arg:
      - 'network.ip_addrs'
{% endif %}
