base:
  '*':
    - basesystem
    - salt
    - mmonit
    - logrotate.jobs
    - users
    - groups
    - sysctl
    - logging
    - webplatform
    - webplatform.dreamobjects

  # OpenStack/DreamCompute AND salt only
  'salt* and G@virtual:kvm':
    - match: compound
    - salt.dreamcompute

  # salt AND Vagrant only
  'salt* and G@biosversion:VirtualBox':
    - match: compound
    - workbench.salt

  # Vagrant only
  'biosversion:VirtualBox':
    - match: grain
    - workbench

  'salt*':
    - salt.master
    - php.composer
    - nodejs

  'roles:frontend':
    - match: grain
    - fxa.frontend


# vim: ai filetype=yaml tabstop=2 softtabstop=2 shiftwidth=2
