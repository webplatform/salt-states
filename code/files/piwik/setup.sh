#!/bin/bash

echo "Applying one-time manual changes to Piwik repo"

cd /srv/code/piwik

if [ -f ".done" ]; then
  echo "There is nothing else to do, setup already done here"
  exit 1
fi

echo "Copying GeoIPCity.dat from latest snapshot in wpd-packages DreamObjects ci bucket"
cp /srv/code/packages/piwik/GeoIPCity.dat repo/misc/


touch .done

exit 0
