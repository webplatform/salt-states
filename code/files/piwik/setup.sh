#!/bin/bash

set -e

echo "Setting things up with the Piwik repo"

cd /srv/code/piwik

if [ -f ".done" ]; then
  echo "There is nothing else to do, setup already done here"
  echo ""
  exit 1
fi

sudo find repo/ -type f -name '*.sh' -exec chmod 775 {} \;

#cd repo
#(composer install)

echo "  * Copying GeoIPCity.dat from latest snapshot in wpd-packages DreamObjects ci bucket"
cp /srv/code/packages/piwik/GeoIPCity.dat /srv/code/piwik/repo/misc/

echo "  * Once you deployed on a targeted node, make sure you check if you need database update"
echo "    Command might look like this:"
echo ""
echo "      php /srv/webplatform/piwik/console core:update"
echo ""

## If we want to fork code based on which version of the setup was run, lets put 1 first
echo '1' > .done

exit 0

