#!/bin/bash

set -e

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
chown -R nobody:deployment /srv/{salt,pillar,private,code}
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
# x     mailhub/repo
# x     web25ee/repo
# x     webat25/repo          Static version of ^

repos["blog"]="https://github.com/webplatform/blog-service.git"
repos["bots"]="git@source.webplatform.org:pierc.git"
repos["mailhub"]="git@source.webplatform.org:mailhub.git"
repos["web25ee"]="git@source.webplatform.org:web25ee.git"
repos["webat25"]="git@source.webplatform.org:webat25.git"
repos["buggenie"]="https://github.com/webplatform/thebuggenie.git"
repos["campaign-bookmarklet"]="https://github.com/webplatform/campaign-bookmarklet.git"
repos["compat"]="https://github.com/webplatform/compatibility-data.git"
repos["dabblet"]="https://github.com/webplatform/dabblet.git"
repos["docsprint-dashboard"]="https://github.com/webplatform/DocSprintDashboard.git"
repos["piwik"]="https://github.com/piwik/piwik.git"
repos["specs"]="https://github.com/webspecs/docs.git"
repos["wiki"]="https://github.com/webplatform/mediawiki-core.git"
repos["www"]="https://github.com/webplatform/www.webplatform.org.git"
repos["notes-server"]="https://github.com/webplatform/annotation-service.git"

## Robin repository to deploy #TODO
#repos["webspecs_bikeshed"]="https://github.com/webspecs/bikeshed.git"  branch webspecs
#https://github.com/webspecs/assets.git"
#https://github.com/webspecs/docs.git"
#https://github.com/webspecs/the-index.git"
#https://github.com/webspecs/publican.git

options["blog"]="--recurse-submodules --quiet"
options["bots"]="--quiet"
options["mailhub"]="--quiet"
options["web25ee"]="--quiet"
options["webat25"]="--quiet"
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

#salt-call --local --log-level=quiet git.config_set setting_name=user.email setting_value="hostmaster@webplatform.org" is_global=True
#salt-call --local --log-level=quiet git.config_set setting_name=user.name setting_value="WebPlatform Continuous Build user" is_global=True

#salt-call --local --log-level=quiet git.config_set setting_name=core.autocrlf setting_value=true is_global=True

salt-call --local --log-level=quiet git.config_set setting_name=core.editor setting_value=vim is_global=True

echo "We will be cloning code repositories:"

for key in ${!repos[@]}; do
    if [ "${key}" == "wiki" ]; then
      if [ ! -d "/srv/code/${key}/repo/mediawiki/.git" ]; then
        echo " * Cloning MediaWiki (its a special case)"
        mkdir -p /srv/code/${key}/repo/mediawiki
        chown -R nobody:deployment /srv/code/${key}/repo/mediawiki
        (salt-call --local --log-level=quiet git.clone /srv/code/${key}/repo/mediawiki ${repos[${key}]} opts="${options[${key}]}" user="renoirb")
        mkdir /srv/code/${key}/repo/settings.d
      else
        echo " * Repo /srv/code/${key}/repo/mediawiki already cloned. Did nothing."
      fi
    else
      if [ ! -d "/srv/code/${key}/repo/.git" ]; then
        echo " * Cloning into /srv/code/${key}/repo"
        mkdir -p /srv/code/${key}
        chown -R nobody:deployment /srv/code/${key}
        (salt-call --local --log-level=quiet git.clone /srv/code/${key}/repo ${repos[${key}]} opts="${options[${key}]}" user="renoirb")
      else
        echo " * Repo in /srv/code/${key}/repo already cloned. Did nothing."
      fi
    fi
done

chown -R nobody:deployment /srv/code/
find /srv/code -type f -exec chmod 664 {} \;
find /srv/code -type d -exec chmod 775 {} \;

echo "Now its time to run wpd-dependency-installer.sh"


clear

echo ""
echo "Step 3 of 3 completed!"
echo ""
echo "Last step, install deployable code dependencies:"
echo "  wpd-dependency-installer.sh"
echo ""

exit 0
