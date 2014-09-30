include:
  - percona

percona-xtradb-cluster-full-56:
  pkg:
    - installed

# This should configured instead #TODO!
apparmor:
  pkg:
    - purged
