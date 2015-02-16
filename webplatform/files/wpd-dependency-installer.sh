#!/bin/bash

#title           :wpd-dependency-installer.sh
#description     :This script reads a list of dependency manifests and run install (or equivalent) on them
#author          :Renoir Boulanger <renoir@w3.org>
#date            :20141128
#version         :0.1
#bash_version    :4.3
#=========================================================================================================

echo 'not ready to use'
exit 1

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

##
## Array of every project dependency management manifests you want to deploy
##
depFiles=( $(find $CODE_PATH -maxdepth 2 -type f -regex ".*\(\(package\|composer\|bower\)\.json\|Gemfile\|\.gitmodules\)") )

##
## Add to the array the ones that doesn’t fit so far so we can handle them
##
## 20141128:
##   - We should eventually have MediaWiki import those dependencies from the root, and not like that #TODO
##   - We do not support yet python and requirements.txt, we have to find the most popular convention among our apps that we deploy #TODO

#=========================================================================================================

declare -A cmdMaps
declare -A cmdDeps

## Note that the key (e.g. package_json) is a lowercased version of the file name
## and the file extension is replaced by an underscore.
## Both arrays should have matching keys in cmdDeps and cmdMaps

##
## List the debian packages you need for each supported package manager
##
cmdDeps["package_json"]="npm"
cmdDeps["composer_json"]="php5-curl:php5-cli"
cmdDeps["bower_json"]="npm"
cmdDeps["gemfile"]="bundler:ruby-full"
cmdDeps["_gitmodules"]="git-core"
cmdDeps["requirements_txt"]="python-virtualenv:python-pip"

##
## List the typical "install" command that should be run
##
cmdMaps["package_json"]="npm install"
cmdMaps["composer_json"]="composer install"
cmdMaps["bower_json"]="bower install"
cmdMaps["gemfile"]="bundle install"
cmdMaps["_gitmodules"]="git submodule update --init --recursive"
cmdMaps["requirements_txt"]="python-virtualenv:python-pip"


# Source: http://superuser.com/questions/427318/test-if-a-package-is-installed-in-apt
is_installed() {
  dpkg-query -Wf'${db:Status-abbrev}' "$1" 2>/dev/null | grep -q '^i'
}

install_for() {
  echo "  * Will install missing component $1"
  case "$1" in
      bower)
        sudo npm install -g bower
      ;;
      composer)
        curl -sS https://getcomposer.org/installer | php
        sudo mv composer.phar /usr/local/bin/composer
      ;;
      * )
        return 0
      ;;
  esac
}

normalize_key() {
  basename ${1,,} | tr . _
}

cmd_available() {
  [ ! -z "$(which $1)" ]
}


echo "About to run install on all dependency managers"

for pathName in ${depFiles[@]}; do
    # Make sure the file exist
    echo "Looking up ${pathName}:"
    if [ -f "${pathName}" ]; then

      # Normalize dependency name to match with keys in cmdDeps and cmdMaps
      depName=$(normalize_key ${pathName})
      # Name of the file, without the full path
      depFile=$(basename ${pathName})
      # Name of the directory containing the dependency file
      dirName=$(dirname ${pathName})

      # Check dependency based on normalized name
      if [ ! -z "${cmdMaps[${depName}]}" ]; then
        cd ${dirName}
        commandString=${cmdMaps[${depName}]}
        commandName=${commandString%% *}

        echo "  * Will run ${commandName}"

        # Ensure we have required package to run installer
        for depElement in ${cmdDeps//:/ }; do
          # Ensure we install missing debian package first
          if ! is_installed "${depElement}"; then
            echo "  * ${depElement} is not installed, installing"
            (apt-get install -y ${depElement})
          fi
        done
        # /Ensure we have required package to run installer

        # Make sure system has command available to us, or install it
        if ! cmd_available "${commandName}"; then
          echo "  * Command ${commandName} unavailable for ${depName} !"
          install_for ${depName}
        fi

        # Run the dependency
        if [ ! -f "${depName}.log" ]; then
          echo "  * Launching ${commandString} in `pwd`"
          ( ${commandString} >>${depName}.log 2>&1 )
          echo "  ... done"
          echo ""
        else
          echo "  * Dependencies already installed"
          echo ""
        fi

      else
        echo "  * No dependency package defined for ${depName}"
        echo ""
      fi
    else
      echo "  * Dependency file ${pathName} not found"
      echo ""
    fi
done

