include:
  - mmonit

make-single-purpose-db-server:
  pkg.installed:
    - pkgs:
      - python-mysqldb
      - mariadb-server
      - mariadb-client

misc-deps:
  pkg.installed:
    - pkgs:
      - iftop

#
# NOC VM configuration
# ... rest has to be done manually for now until we finish up what tools we deploy
#
#      - suricata
#
# wget http://mmonit.com/dist/mmonit-3.4-linux-x64.tar.gz
# tar xfz mmonit-3.4-linux-x64.tar.gz
# mv mmonit-3.4-linux-x64 /srv/mmonit
# cd /srv/mmonit
# cat conf/server.xml
# <?xml version="1.0" encoding="UTF-8"?>
# <Server>
#   <Service>
#     <Connector address="*" port="8080" processors="10" />
#     <Engine name="mmonit" defaultHost="localhost" fileCache="10MB">
#       <Realm url="mysql://mmonit:w7yzeS44kGjYX7Dmt7@127.0.0.1/mmonit"
#         minConnections="5"
#         maxConnections="25"
#         reapConnections="300" />
#       <ErrorLogger directory="logs" fileName="error.log" rotate="month" />
#       <Host name="localhost" appBase=".">
#         <Context path="" docBase="docroot" sessionTimeout="1800"
#           maxActiveSessions="1024" saveSessions="true" />
#         <Context path="/collector" docBase="docroot/collector" />
#       </Host>
#    <\Engine>
#  </Service>
# <\Server>
#
# salt noc mysql.db_create mmonit utf8 utf8_general_ci
# salt noc mysql.user_create mmonit localhost w7yzeS44kGjYX7Dmt7
# salt noc mysql.grant_add 'ALL' 'mmonit.*' 'mmonit' localhost grant_option=True
#
# ref: http://mmonit.com/wiki/MMonit/Setup
#
# Suricata
#  - http://suricata-ids.org/features/all-features/
#  - https://redmine.openinfosecfoundation.org/projects/suricata/wiki/What_is_Suricata
# wget https://rules.emergingthreatspro.com/open/suricata/emerging.rules.tar.gz
#
# https://www.snorby.org/
# http://www.backtrack-linux.org/wiki/index.php/OpenVas
# http://stephenfritz.blogspot.ca/2014/05/linux-with-suricata-barnyard2-and-snorby.html
# https://www.librato.com/
# http://grafana.org/
# http://influxdb.com/docs/v0.8/introduction/overview.html
# http://vincent.composieux.fr/article/grafana-monitor-metrics-collected-by-collectd-into-influxdb
