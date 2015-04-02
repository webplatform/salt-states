    # @gitfs-dependency: docker-formula
    # ref: https://github.com/saltstack-formulas/docker-formula
    {% set salt_master_ip = salt['pillar.get']('infra:hosts_entries:salt') -%}
    {%- set kernelrelease = salt['grains.get']('kernelrelease') %}

    include:
      - docker

    /etc/default/docker:
      file.managed:
        - source: salt://webplatform/files/docker/default.jinja
        - template: jinja
        - context:
            cli_opts: --dns {{ salt_master_ip }} --dns 8.8.8.8 -s aufs
        - watch_in:
          - service: docker-service
        - require:
          - pkg: lxc-docker
          - pkg: linux-kernel-deps

    linux-kernel-deps:
      pkg.installed:
        - pkgs:
          - linux-image-extra-{{ kernelrelease }}
          - aufs-tools
      cmd.run:
        - name: modprobe aufs
        - unless: modinfo aufs > /dev/null 2>&1

