#!/bin/bash

echo "Applying one-time manual changes to wiki repo"

cd /srv/code/wiki

if [ -f ".done" ]; then
  echo "There is nothing else to do, setup already done here"
  exit 1
fi

echo "Patching issue-19 for SocialProfile image patch"
cd /srv/code/wiki/repo/mediawiki
patch -p1 < patches/issue-19.patch

echo "Installing manually composer dependencies that aren’t yet part of core MW"
cd /srv/code/wiki/repo/mediawiki/extensions/WebPlatformDocs
(composer install)

cd /srv/code/wiki

touch .done

exit 0
