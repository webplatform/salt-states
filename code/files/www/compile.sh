#!/bin/bash

# Managed by Salt stack. Do NOT EDIT directly!

#
# Compile the static site for publication
#

if [ ! -d "/srv/code/www/repo/.git" ]; then
  echo "This script cannot be run"
  exit 1
fi

cd /srv/code/www

if [ ! -d "archives" ]; then
  sudo mkdir -m 774 archives
  sudo chown -R nobody:deployment archives
fi

if [ ! -d "repo/node_modules" ]; then
  echo "You didnt run npm install, nor bundle install"
  exit 1
fi

sudo chmod +x repo/node_modules/docpad/bin/docpad
sudo chmod +x repo/node_modules/gulp/bin/gulp.js

sudo mkdir -p -m 774 repo/out
sudo chown -R nobody:deployment repo/out

cd repo

compass compile -e production --force
node_modules/docpad/bin/docpad generate --env=production
node_modules/gulp/bin/gulp.js minify --env=production
tar cfj ../archives/package-$(date '+%Y%m%d%H').tar.bz2 out/
