ganglia-webfrontend:
  pkg.installed

# Fixing error: 'PHP Notice:  Undefined variable: private in /usr/share/ganglia-webfrontend/auth.php on line 27'
/usr/share/ganglia-webfrontend/auth.php:
  file.patch:
    - source: salt://monitor/auth.php.patch
    - hash: md5=480ef2ae17fdfee85585ab887fa1ae5f

# Fixing: ' PHP Notice:  Undefined index: 10.4.190.195 in /usr/share/ganglia-webfrontend/functions.php on line 268'
/usr/share/ganglia-webfrontend/functions.php:
  file.patch:
    - source: salt://monitor/functions.php.patch
    - hash: md5=4eb9c7c3dc7fdeb1c92b0a81b0ace764

/usr/share/ganglia-webfrontend/cluster_legend.html:
  file.managed:
    - source: salt://monitor/files/cluster_legend.html
    - require:
      - pkg: ganglia-webfrontend
