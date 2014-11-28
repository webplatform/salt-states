#!/bin/bash

set -e

echo "Setting things up with the WebSpecs bikeshed fork repo"

cd /srv/code/webspecs_bikeshed

if [ -f ".done" ]; then
  echo "There is nothing else to do, setup already done here"
  echo ""
  exit 1
fi

cd repo

sudo apt-get install python2.7 python-dev python-pip libxslt1-dev libxml2-dev
virtualenv --no-site-packages --distribute .;
sudo pip install lxml
sudo pip install --editable /srv/code/webspecs_bikeshed/repo/

cd ../

## If we want to fork code based on which version of the setup was run, lets put 1 first
echo '1' > .done

exit 0

