#!/bin/bash

set -e

echo "Setting things up with the webat25.org ExpressionEngine repo"

cd /srv/code/web25ee

if [ -f ".done" ]; then
  echo "There is nothing else to do, setup already done here"
  exit 1
fi

echo "Creating missing directory"
mkdir -p repo/images/avatars/uploads

echo "Copying cache handler"
cp /srv/code/packages/web25ee/_static_cache_handler.php repo/

## If we want to fork code based on which version of the setup was run, lets put 1 first
echo '1' > .done

exit 0
