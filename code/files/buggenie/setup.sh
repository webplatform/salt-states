#!/bin/bash

set -e

echo "Setting things up with the BugGenie repo"

cd /srv/code/buggenie

if [ -f ".done" ]; then
  echo "There is nothing else to do, setup already done here"
  echo ""
  exit 1
fi

sudo chmod 775 repo/tbg_cli

## If we want to fork code based on which version of the setup was run, lets put 1 first
echo '1' > .done

exit 0

