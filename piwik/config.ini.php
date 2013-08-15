; <?php exit; ?> DO NOT REMOVE THIS LINE
;
; this file for documentation purposes; DO NOT COPY this file to config.ini.php;
; the config.ini.php is normally created during the installation process
; (see http://piwik.org/docs/installation)
; when this file is absent it triggers the Installation process to create
; config.ini.php; that file will contain the superuser and database access info

[superuser]
login     = admin
password  = 00000000000000000000000000000000
email     = team-webplatform-systems@w3.org

[database]
host          = 10.4.207.83
username      = piwikuser
password      = 16nP2q8kzbU3xtom711a
dbname        = wpstats
adapter       = MYSQLI ; PDO_MYSQL, MYSQLI, or PDO_PGSQL
tables_prefix = piwik_
;charset      = utf8

[General]
session_save_handler    = dbtable
proxy_client_headers[]  = HTTP_X_FORWARDED_FOR
proxy_host_headers[]    = HTTP_X_FORWARDED_HOST
