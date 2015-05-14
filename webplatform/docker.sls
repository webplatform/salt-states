# @gitfs-dependency: docker-formula
# ref: https://github.com/saltstack-formulas/docker-formula
{% set salt_master_ip = salt['pillar.get']('infra:hosts_entries:salt') -%}
{%- set kernelrelease = salt['grains.get']('kernelrelease') %}

include:
  - docker
  - docker.compose
  - users.app-user

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

docker:
  group.present:
    - system: True
    - addusers:
      - webapps
    - require:
      - user: webapps

linux-kernel-deps:
  pkg.installed:
    - pkgs:
      - linux-image-extra-{{ kernelrelease }}
      - aufs-tools
  cmd.run:
    - name: modprobe aufs
    - unless: modinfo aufs > /dev/null 2>&1

# see also:
#  - https://get.docker.com/ubuntu/
# Maybe run:
#  - apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9

#https://pip.pypa.io/en/latest/reference/pip_install.html
#docker-compose:
#  pkg.installed:
#    - pkgs:
#      - python-pip
#      - python3-yaml
#  pip.installed:
#    - name: docker-compose
#    - upgrade: True
