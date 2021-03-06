#!/bin/bash

set -e

echo "Setting things up with the notes-server repo"

cd /srv/code/notes-server

if [ -f ".done" ]; then
  echo "There is nothing else to do, setup already done here"
  exit 1
fi

sudo apt-get install -y python-pip python-virtualenv python-yaml python-dev build-essential python-mysqldb
sudo chmod 775 repo/bootstrap
sudo chmod 775 repo/run

## If we want to fork code based on which version of the setup was run, lets put 1 first
echo '1' > .done

exit 0

