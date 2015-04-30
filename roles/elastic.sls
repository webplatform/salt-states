# Role to use to run ElasticSearch cluster
# We need at least one. Typically called elastic1.
# The Main ElasticSearch server is handled automatically by the available nodes.

include:
  - elasticsearch.snapshots_nfs

#salt backup1 service.restart nfs-kernel-server
