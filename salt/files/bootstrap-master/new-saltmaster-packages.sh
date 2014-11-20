#!/bin/bash

#
# Bootstrapping a new WebPlatform salt master (step 2)
#
# *The packages we share accross the infrastructure*
#
# This script is meant to be run only once per salt master
# so that every code dependencies are cloned and installed
# in a constant fashion.
#
# A salt master should have NO hardcoded files and configuration
# but simply be booted bootstrapped by the three following components.
#
# 1. Cloning Salt configurations (so we can salt the salt master)
# 2. The packages we share accross the infrastructure
# 3. Cloning every webplatform.org software dependencies.

if [ ! -f "/srv/ci-dreamobjects.sh" ]; then
    echo "Cannot find ci-dreamobjects, did you run state.highstate yet?"
    exit 1
fi

cd /srv
. ci-dreamobjects.sh
mkdir -p code/packages
cd code/packages
swift list wpd-packages > filesList
while read FILE; do swift download wpd-packages $FILE ; done < filesList
rm filesList
chown -R nobody:deployment /srv/code/packages
