#!/bin/bash

echo "Applying one-time manual changes to web25ee repo (www.webat25.org)"

cd /srv/code/web25ee

if [ -f ".done" ]; then
  echo "There is nothing else to do, setup already done here"
  exit 1
fi

echo "Creating missing directory"
mkdir -p repo/images/avatars/uploads

echo "Copying cache handler"
cp /srv/code/packages/web25ee/_static_cache_handler.php repo/

touch .done

exit 0
