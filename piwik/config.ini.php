; <?php exit; ?> DO NOT REMOVE THIS LINE
[superuser]
login     = admin
password  = 00000000000000000000000000000000
email     = team-webplatform-systems@w3.org

[database]
host          = master.db.wpdn
username      = piwikuser
password      = 16nP2q8kzbU3xtom711a
dbname        = wpstats
tables_prefix = piwik_

[General]
session_save_handler    = dbtable
proxy_client_headers[]  = HTTP_X_FORWARDED_FOR
proxy_host_headers[]    = HTTP_X_FORWARDED_HOST
noreply_email_address   = team-webplatform-systems@w3.org
