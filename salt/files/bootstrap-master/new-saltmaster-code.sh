#!/bin/bash

#
# Bootstrapping a new WebPlatform salt master (step 3)
#
# *Cloning every webplatform.org software dependencies*
#
# This script is meant to be run only once per salt master
# so that every code dependencies are cloned and installed
# in a constant fashion.
#
# A salt master should have NO hardcoded files and configuration
# but simply be booted bootstrapped by the three following components.
# 
# 1. Salt configurations (so we can salt the salt master)
# 2. The packages we share accross the infrastructure
# 3. Cloning every webplatform.org software dependencies.
#

declare -r SALT_BIN=`which salt`

if [ -z "${SALT_BIN}" ]; then
  echo "This machine isn’t a salt master" 
  exit 1
fi

echo "Setting file ownership on salt master checkouts"
chown -R nobody:deployment /srv/{salt,pillar,private}
find /srv/salt -type f -exec chmod 664 {} \;
find /srv/pillar -type f -exec chmod 664 {} \;
find /srv/private -type f -exec chmod 660 {} \;
find /srv/salt -type d -exec chmod 775 {} \;
find /srv/pillar -type d -exec chmod 775 {} \;
find /srv/private -type d -exec chmod 770 {} \;
chmod 755 /srv/salt/_grains/*.py

echo "About to clone code..."

cd /srv/code

declare -A repos
declare -A options

## SPECIAL CASES
# n     accounts/
#       certificates/         NOTE: not source controlled use salt and private!!
#       gerrit/
#       packages/
# n     utilities/

## CODE REPOS
# x     blog/repo
# .     bots/lumberjack/repo
# x     buggenie/repo         @webplatform-customizations
# .     campaign-bookmarklet
# x     compat/repo
# x     dabblet/repo          @webplatform-customizations
# .     docsprint-dashboard 
# x     piwik/repo            @2.8.0 (upstream)
# x     specs/repo                                                           requires out and archives too
# x     wiki/repo/mediawiki   @1.24wmf16-wpd                                 requires ../cache/ ../settings.d/
# x     www/repo              see https://source.webplatform.org/r/#/c/13/   requires ../out/ ../archives/

repos["blog"]="https://github.com/webplatform/webplatform-wordpress-theme.git"
repos["bots"]="https://@source.webplatform.org/r/pierc.git"
repos["buggenie"]="https://github.com/webplatform/thebuggenie.git"
repos["campaign-bookmarklet"]="https://github.com/webplatform/campaign-bookmarklet.git"
repos["compat"]="https://github.com/webplatform/compatibility-data.git"
repos["dabblet"]="https://github.com/webplatform/dabblet.git"
repos["docsprint-dashboard"]="https://github.com/webplatform/DocSprintDashboard.git"
repos["piwik"]="https://github.com/piwik/piwik.git"
repos["specs"]="https://github.com/webspecs/docs.git"
repos["wiki"]="https://github.com/webplatform/mediawiki-core.git"
repos["www"]="https://github.com/webplatform/www.webplatform.org.git"
repos["notes-server"]="https://github.com/webplatform/notes-server.git"


options["blog"]="--recurse-submodules --quiet"
options["bots"]="--quiet"
options["buggenie"]="--branch webplatform-customizations --quiet"
options["campaign-bookmarklet"]="--quiet"
options["compat"]="--quiet"
options["dabblet"]="--branch webplatform-customizations --quiet"
options["docsprint-dashboard"]="--quiet"
options["piwik"]="--branch 2.9.0 --recurse-submodules --quiet"
options["specs"]="--quiet"
options["wiki"]="--branch 1.24wmf16-wpd --recurse-submodules --quiet"
options["www"]="--quiet"
options["notes-server"]="--quiet"

#salt-call --local --log-level=quiet git.clone /srv/salt ssh://renoirb@source.webplatform.org:29418/salt-states  opts="--branch 201409-removing-private-data --quiet" user="dhc-user" identity="/home/dhc-user/.ssh/id_rsa"
#salt-call --local --log-level=quiet git.remote_set $CODE_DIR/www/repo gerrit https://source.webplatform.org/r/www.webplatform.org
#salt-call --local --log-level=quiet git.remote_set $CODE_DIR/notes-server/repo gerrit https://source.webplatform.org/r/notes-server
#salt-call --local git.config_set setting_name=user.email setting_value="hostmaster@webplatform.org" is_global=True
#salt-call --local git.config_set setting_name=user.name setting_value="WebPlatform Continuous Build user" is_global=True
#salt-call --local git.config_set setting_name=core.editor setting_value=vim is_global=True
#salt-call --local git.config_set setting_name=core.autocrlf setting_value=true is_global=True


echo "We will be cloning code repositories:"

for key in ${!repos[@]}; do
    if [ "${key}" == "wiki" ]; then 
      if [ ! -d "/srv/code/${key}/repo/mediawiki/.git" ]; then
        echo " * Cloning MediaWiki (its a special case)"
        mkdir -p /srv/code/${key}/repo/mediawiki
        chown nobody:deployment /srv/code/${key}/repo/mediawiki
        (salt-call --local --log-level=quiet git.clone /srv/code/${key}/repo/mediawiki ${repos[${key}]} opts="${options[${key}]}" user="nobody")
        mkdir /srv/code/${key}/repo/settings.d
        cd /srv/code/${key}/repo/mediawiki/extensions/WebPlatformDocs
        (composer install)
        cd /srv/code
      else
        echo " * Repo /srv/code/${key}/repo/mediawiki already cloned. Did nothing."
      fi
    else
      if [ ! -d "/srv/code/${key}/repo/.git" ]; then
        echo " * Cloning into /srv/code/${key}/repo"
        mkdir -p /srv/code/${key}
        chown nobody:deployment /srv/code/${key}
        (salt-call --local --log-level=quiet git.clone /srv/code/${key}/repo ${repos[${key}]} opts="${options[${key}]}" user="nobody")
        if [ -f "/srv/code/${key}/repo/Gemfile" ]; then
          echo " * Running Gemfile dependencies"
          cd /srv/code/${key}/repo/
          (bundle install)
          cd /srv/code 
        fi
        if [ -f "/srv/code/${key}/repo/generator/package.json" ]; then
          echo " * Dealing with Robin’s difference with npm"
          cd /srv/code/${key}/repo/generator
          (npm install)
          cd /srv/code
        fi
      else
        echo " * Repo in /srv/code/${key}/repo already cloned. Did nothing."
      fi
    fi
done

chown -R nobody:deployment /srv/code/
find /srv/code -type f -exec chmod 664 {} \;
find /srv/code -type d -exec chmod 775 {} \;

echo "Job’s done"
exit 0
