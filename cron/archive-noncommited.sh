#!/bin/bash

output=$(mktemp)

if [ -z "${GITFOLDER}" ] ; then
  echo "No folder with git given. Please set GITFOLDER in environment."
  exit 1
fi

if [ ! -d "${GITFOLDER}/.git" ] ; then
  echo "Folder ${GITFOLDER} is not a Git repository."
  exit 1
fi

if [ ! -d "${GITFOLDER}-archives" ] ; then
  echo "Folder ${GITFOLDER}-archives does not exist. Please create"
  exit 1
fi

cd $GITFOLDER
git ls-files --others --exclude-standard | tar czf ${GITFOLDER}-archives/uploads-$(date '+%Y%m%d%H%M').tar.gz -T -  > $output 2>&1

if [ "$?" -ne 0 ] ; then
  cat $output
  rm $output
  exit 1
fi
rm $output
