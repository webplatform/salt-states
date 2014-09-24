/srv/webplatform:
  file:
    - directory
    - user: root
    - group: root
    - mode: 755
    - makedirs: True

non-needed-softwares:
  pkg.removed:
    - pkgs:
      - landscape-common
      - landscape-client

commonly-used-utilities:
  pkg.installed:
    - names:
      - screen
      - htop
      - sysstat

/usr/bin/timeout:
  file.exists

sysstat:
  service.running:
    - enable: True
    - reload: True
    - require:
      - pkg: sysstat
    - watch:
      - file: /etc/default/sysstat

/etc/default/sysstat:
  file.managed:
    - source: salt://webplatform/files/default-sysstat.jinja
    - template: jinja
    - require:
      - pkg: sysstat

/etc/sysctl.conf:
  file.append:
    - text: |
        #
        ###################################################################
        # WebPlatform Docs; Attempt fixing memory allocation issue
        # Attempt on fixing "X invoked oom-killer: gfp_mask=, order=0, oom_adj=0"
        # http://askubuntu.com/questions/161521/why-does-my-server-freeze-everyday-at-the-same-time
        # http://www.hskupin.info/2010/06/17/how-to-fix-the-oom-killer-crashe-under-linux/
        # https://www.kernel.org/doc/Documentation/vm/overcommit-accounting
        vm.overcommit_memory = 2
        vm.overcommit_ratio = 80
