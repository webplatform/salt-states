#!/bin/bash

# Managed by Salt stack. Do NOT EDIT directly!

#
# Compile the static site for publication
#

if [ ! -d "/srv/code/www/repo/.git" ]; then
  echo "This script cannot be run"
  exit 1
fi

cd /srv/code/www/repo

if [ ! -d "../archives/" ]; then
  sudo mkdir ../archives/
  sudo chmod g+w ../archives/
fi
sudo chmod +x node_modules/docpad/bin/docpad
sudo chmod +x node_modules/gulp/bin/gulp.js

sudo chown -R nobody:deployment out/
sudo chmod g+w out

compass compile -e production --force
node_modules/docpad/bin/docpad generate --env=production
node_modules/gulp/bin/gulp.js minify --env=production
tar cfj ../archives/package-$(date '+%Y%m%d%H').tar.bz2 out/
