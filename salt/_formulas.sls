{%- set formulas_repos = salt['pillar.get']('basesystem:salt:formulas_repos') %}

#
# Possible confusion point here, sorry about that.
#
# Idea is that if we are in VirtualBox, we want to clone formulas.
# In a Vagrant Workbench, we can know this fact by checking if we have
# a file at /etc/salt/minion.d/workbench.conf
#
# The salt/master.sls should have a similar block
# than the one in salt/new_master.sls for gitfs.conf and roots.conf
#
# For now, lets only support local formula workbench on VirtualBox VMs
#
#


/etc/salt/master.d/roots.conf:
  file.managed:
    - source: salt://salt/files/roots.conf.jinja
    - template: jinja


{% if grains['biosversion'] == 'VirtualBox' -%}

{%- from "basesystem/macros/git.sls" import git_clone_loop -%}

{{ git_clone_loop(formulas_repos)}}

/etc/salt/master.d/gitfs.conf:
  file.managed:
    - contents: |
        # Managed by Salt stack, do NOT EDIT manually!
        #
        # We are in a VirtualBox VM, its been treated as
        # a vagrant-workbench. We won't use GitFS, but
        # clone the formulas so we can work on them.
        #
        # Look at /etc/salt/master.d/roots.conf
        #
        # We should get all the formulas from the
        # basesystem:salt:formulas_repos pillar

{% for creates,args in formulas_repos.items() %}
{%- set slug = creates.split("/")|last() -%}
Add {{ creates }} into Workbench /etc/salt/master.d/roots.conf:
  cmd.run:
    - name: echo "    - {{ creates }}" >> /etc/salt/master.d/roots.conf
    - unless: grep -q -e "formulas\/{{ slug }}" /etc/salt/master.d/roots.conf

{% endfor %}

{% else -%}

/etc/salt/master.d/gitfs.conf:
  file.managed:
    - source: salt://salt/files/gitfs.conf

{% for creates,args in formulas_repos.items() %}
{% set slug = creates.split("/")|last() %}
Add {{ creates }} into /etc/salt/master.d/gitfs.conf:
  cmd.run:
    - name: echo "    - {{ creates }}" >> /etc/salt/master.d/gitfs.conf
    - unless: grep -q -e "formulas\/{{ slug }}" /etc/salt/master.d/gitfs.conf
{% endfor %}

{% endif %}