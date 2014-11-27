#!/bin/bash

echo "Applying one-time manual changes to Piwik repo"

cd /srv/code/piwik

if [ -f ".done" ]; then
  echo "There is nothing else to do, setup already done here"
  exit 1
fi

sudo find repo/ -type f -name '*.sh' -exec chmod +x {} \;

cd repo
(composer install)

echo "Copying GeoIPCity.dat from latest snapshot in wpd-packages DreamObjects ci bucket"
cp /srv/code/packages/piwik/GeoIPCity.dat /srv/code/piwik/repo/misc/

echo "Once you deployd on a targeted node, make sure you check if you need database update"
echo "You might be asked to do: php /srv/webplatform/piwik/console core:update"

## If we want to fork code based on which version of the setup was run, lets put 1 first
echo '1' > .done

exit 0
