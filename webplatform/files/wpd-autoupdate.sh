#!/bin/bash

if [ "$CODE_PATH" == "" ]; then
    echo "Please provide the CODE_PATH env variable"
    exit 1
fi

if [ ! -d "$CODE_PATH" ]; then
    MSG="[notice] Host `hostname` autoupdater `pwd` -- no code directory found"
    logger -i -p local1.notice -t cron $MSG
    echo $MSG
    exit 2
fi

USER=`whoami`

git fetch --all > /dev/null 2>&1

git_branch(){
  echo $(git symbolic-ref HEAD 2> /dev/null || git rev-parse --short HEAD 2> /dev/null) | sed "s#refs/heads/##"
}

GIT_REMOTE=`git remote show`
GIT_BRANCH=`git_branch`
GIT_HEAD_NAME=`git symbolic-ref HEAD 2> /dev/null`

if [[ $GIT_HEAD_NAME == "refs"* ]]; then
  COUNT=`git rev-list ${GIT_BRANCH}...${GIT_REMOTE}/${GIT_BRANCH} --count`
  if [[ $COUNT ==  1 ]]; then

      git pull --rebase

      ATTEMPT=$?
      if [[ $ATTEMPT == 1 ]]; then

          MSG="[notice] Host `hostname` autoupdate `pwd` has updates but cannot apply them. Did nothing."
          logger -i -p local1.notice -t cron $MSG

      else

          MSG="[notice] Host `hostname` autoupdate `pwd` updated"
          logger -i -p local1.notice -t cron $MSG

      fi

  else

      MSG="[notice] Host `hostname` autoupdate `pwd` nothing to do"
      logger -i -p local1.notice -t cron $MSG

  fi

else

    MSG="[notice] Host `hostname` autoupdate `pwd` detached HEAD, nothing to do"
    logger -i -p local1.notice -t cron $MSG

fi

exit 0
