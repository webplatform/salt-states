# Roles to expose Both Redis AND Memcached only for session storage
# Sessions MUST be stored in a separate cluster than other Redis/Memcache cluster
# We need at least one node, typically called sessions1
