#!/bin/bash
#

declare -A saltdir

saltdir[dabblet]="/srv/code/dabblet"
saltdir[ext.CompaTables]="/srv/code/docs/current/extensions/"
saltdir[skins]="/srv/code/docs/current/skins/"

GITMEDIAWIKI="https://github.com/webplatform/mediawiki"
WPENV="code.docs_test"

usage ()
{
cat << EOF
Usage: deploy.sh [-c] CODEBASE 
This script allows you to deploy:
  - dabblet
  - mediawiki extensions
  - mediawiki skins

Available CODEBASE:
`for key in ${!saltdir[@]}; do echo "- $key"; done`

By default, the script deploy mediawiki extensions and skins on docs_test.
Use the option "-c" to deploy on docs_current.
EOF
}

while getopts c opt
do
    case "$opt" in
      c) WPENV="code.docs_current"
        shift
        ;;
    esac
done

if [ $# -ne 1 ]; then
  usage
  exit 0
elif [ "x${saltdir[$1]}" = "x" ]; then
  echo -e "\e[1;41mThis CODEBASE is not available\e[0m"
  usage
  exit 0
fi

if [ $1 = "dabblet" ]; then
  (echo -e "\e[1;42m==== Pull webplatform/dabblet ====\e[0m"
   cd ${saltdir[$1]}
   git pull
   echo -e "\e[1;42m==== Running salt-run deploy.run code.dabblet ====\e[0m"
   sudo salt-run deploy.run code.dabblet)
elif [[ $1 = ext.* ]]; then
  (echo -e "\e[1;42m==== Clone webplatform/mediawiki ====\e[0m"
   cd /tmp && git clone $GITMEDIAWIKI
   cd /tmp/mediawiki/extensions
   cp -rf ${1/ext./} ${saltdir[$1]} && cd
   rm -rf /tmp/mediawiki
   echo -e "\e[1;42m==== Running salt-run deploy.run $WPENV ====\e[0m"
   sudo salt-run deploy.run $WPENV)
 elif [[ $1 = skins ]]; then
  (echo -e "\e[1;42m==== Clone webplatform/mediawiki ====\e[0m"
   cd /tmp && git clone $GITMEDIAWIKI
   cd /tmp/mediawiki/
   cp -rf skins/{webplatform,common,WebPlatform.php} ${saltdir[$1]} && cd
   rm -rf /tmp/mediawiki
   echo -e "\e[1;42m==== Running salt-run deploy.run $WPENV ====\e[0m"
   sudo salt-run deploy.run $WPENV)
fi

