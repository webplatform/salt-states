ganglia-webfrontend:
  pkg.installed

# Fixing error: 'PHP Notice:  Undefined variable: private in /usr/share/ganglia-webfrontend/auth.php on line 27'
#
#/usr/share/ganglia-webfrontend/cluster_legend.html:
#  file.managed:
#    - source: salt://monitor/files/cluster_legend.html
#    - require:
#      - pkg: ganglia-webfrontend
#
#/usr/share/ganglia-webfrontend/node_legend.html:
#  file.managed:
#    - source: salt://monitor/files/node_legend.html
#    - require:
#      - pkg: ganglia-webfrontend
