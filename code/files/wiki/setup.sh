#!/bin/bash

set -e

echo "Setting things up with the MediaWiki repo"

cd /srv/code/wiki

if [ -f ".done" ]; then
  echo "There is nothing else to do, setup already done here"
  exit 1
fi

echo "Patching issue-19 for SocialProfile image patch"
cd /srv/code/wiki/repo/mediawiki
patch -p1 < patches/issue-19.patch

#echo "Installing manually composer dependencies that aren’t yet part of core MW"
#cd /srv/code/wiki/repo/mediawiki/extensions/WebPlatformDocs
#(composer install)

cd /srv/code/wiki

## If we want to fork code based on which version of the setup was run, lets put 1 first
echo '1' > .done

exit 0
