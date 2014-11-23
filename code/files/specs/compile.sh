#!/bin/bash

# Managed by Salt stack. Do NOT EDIT directly!

#
# Compile specs.webplatform.org
#

declare -r CODE_PATH="/srv/code/specs"

if [ ! -d "${CODE_PATH}/repo/generator" ]; then
  echo "This script cannot be run" 
  exit 1
fi

cd ${CODE_PATH}/repo/generator

if [ ! -d "${CODE_PATH}/out" ]; then
  mkdir ${CODE_PATH}/out
fi

if [ ! -d "${CODE_PATH}/archives" ]; then
  mkdir ${CODE_PATH}/archives
fi

nodejs ./run.js

cd ${CODE_PATH}/repo

if [ -d "out" ]; then
  rm -rf out
fi

cp -r * ${CODE_PATH}/out
cd ${CODE_PATH}
rm -rf out/generator out/compile.sh out/README.md out/LICENSE
tar cfj archives/package-$(date '+%Y%m%d%H').tar.bz2 out/
mv out /srv/code/specs/repo/out
