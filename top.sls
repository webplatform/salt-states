base:
  '*':
    - basesystem
    - salt
    - mmonit
    - logrotate.jobs
    - users
    - groups
    - sudo
    - webplatform
    - webplatform.dreamobjects
    - sysctl
    - logging

  # OpenStack/DreamCompute AND salt only
  'salt* and G@virtual:kvm':
    - match: compound
    - salt.dreamcompute
    - nodejs.dreamcompute

  # salt AND Vagrant only
  'salt* and G@biosversion:VirtualBox':
    - match: compound
    - workbench.salt

  # Vagrant only
  'biosversion:VirtualBox':
    - match: grain
    - workbench

  'salt*':
    - webplatform.formulas.docker
    - salt.master
    - nodejs

  'roles:frontend':
    - match: grain
    - fxa.frontend


# vim: ai filetype=yaml tabstop=2 softtabstop=2 shiftwidth=2
