#!/bin/bash

#
# Bootstrapping a new WebPlatform salt master (step 1)
#
# *Cloning Salt configurations*
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
#
# =========================================================================
#
# Note that you can run this bootstrapper on ANY vanilla Ubuntu 14.04 VM and
# it should work just fine. This script takes into account that you might
# might now have a master to start from. If that’s the case, make sure the
# new VM is called "salt.staging.wpdn" (or "salt.production.wpdn") in the
# `/etc/hosts` file and jump to step #5
#
# =========================================================================
#
# STEPS:
#
# From an existing salt-master, do the following;
#
# 1. Get to know the next IP address nova will give:
#
# This is useful so we can tell the new salt master to use the upcoming new
# DNS. Normally, nova rotates +1 private IP addresses. Note that you can
# get to know the IP address, and boot an empty VM from OpenStack Dashboard
# but if you are like the author, better having only shell stuff!
#
#     nova list
#
#
# 2. Edit manually `/srv/salt/salt/master.sls`
#
#     vi /srv/salt/salt/master.sls
#
# Get the `salt_master_ip:` line. Edit with the IP address you expect nova will
# give (e.g. 10.10.10.129).  Run highstate on master
#
#     salt salt state.highstate
#
# It should have updated `/srv/userdata.txt` so that the next VM will know at
# boot time that it should listen to itself as a new salt master.  Note that
# userdata is part of OpenStack and that this script is run at every reboot,
# stating that on subsequent boots to listen to itself instead of another
# IP, that most likely wont exist anymore, prevents potential
# confusion and misdirected network traffic.
#
#
# 3. Using python-novaclient, launch new future salt-master:
#
# We will have two VMs with name `salt` the new one will not have public IP
# address yet. The last step is to ask OpenStack to change the public IP
# address to the new salt master.
#
# Start the new VM:
#
#     nova boot --image Ubuntu-14.04-Trusty \
#               --user-data /srv/userdata.txt \
#               --key_name salt-renoirb \
#               --flavor lightspeed \
#               --security-groups default,all,dns,log-dest,mw-eventlog,salt-master \
#               salt
#
# NOTE: Adjust `key_name` with your secret key that you given in OpenStack dashboard
#       you should have on the salt master. That one is only useful among VMs you
#       control FROM the salt master. It should be available in
#       `/srv/private/pillar/sshkeys/init.sls` as its kept in source control so it
#       can replicate the same setup everywhere.
#
#
# 4. Send this bootstrapper file, get new private IP first
#
# Hopefully the new VM will have the IP address we expected at step 1
#
# If it works, after the following commands, we will resume the work on the new VM.
#
# Double check and continue like this, assuming the new VM private IP *is* ending by `129`:
#
# From current salt master:
#
#     nova list
#     scp /srv/opsconfigs/new-saltmaster.sh dhc-user@10.10.10.129:~
#
# Remember ...129 (in this example) is *also* called salt. Current salt master has public
# key to be accepted on it. Once the file is moved, we can SSH to the new VM. Note that
# we have to SSH from the current salt master as its the one that already has your current
# private/public key for dhc-user already.
#
#
# 5. Launch this bootstrapper
#
# You must be on the new VM at this step. Copy to the new VM this file and you will be
# just fine.
#
# This bootstrapper will initialize everything we need:
# - Instal that node as a salt master
# - Have all states ready to be called `state.highstate` and effectively make it a salt master
# - Have all states so it can *also* pull all /srv/code repositories so it can sync code around
# - Have all scripts so it can also boot VMs
#
# Run this script
#
#    ssh dhc-user@10.10.10.129
#    sudo -s
#    bash new-saltmaster.sh
#
# And go on with the show...
#
clear
cat << "FOO"


                            _    _      _    ______ _       _    __
                           | |  | |    | |   | ___ \ |     | |  / _|
                           | |  | | ___| |__ | |_/ / | __ _| |_| |_ ___  _ __ _ __ ___
                           | |/\| |/ _ \ '_ \|  __/| |/ _` | __|  _/ _ \| '__| '_ ` _ \
                           \  /\  /  __/ |_) | |   | | (_| | |_| || (_) | |  | | | | | |
                            \/  \/ \___|_.__/\_|   |_|\__,_|\__|_| \___/|_|  |_| |_| |_|


                           WebPlatform Infrastructure


We will make this VM as a new Salt master



FOO

apt-get update
apt-get -y install python-git salt-master salt-minion python-dulwich
apt-get -y upgrade
apt-get -y autoremove

echo " "
echo " "
echo "Bootstrapping a new Salt master"

declare -r SALT_BIN=`which salt-call`
declare -r DATE=`date`

if [ -z "${SALT_BIN}" ]; then
  echo "Saltstack doesn’t seem to be installed on that machine"
  exit 1
fi

(cat <<- _EOF_
-----BEGIN RSA PRIVATE KEY-----
INSERT YOUR OWN PRIVATE KEY HERE
-----END RSA PRIVATE KEY-----
_EOF_
) > /home/dhc-user/.ssh/id_rsa

id_rsa_pub=$(cat <<- _EOF_
INSERT YOUR OWN PUBLIC KEY HERE
_EOF_
)

clear
cat << _EOF_

 This script is about cloning git repos. Some of those repos have sensitive
 data.

 In order to import that sensitive data we need a temporary private-public
 keypair. With it, we’ll be able to fetch private data along with public.

 You can create your own keypair and add them to this script yourself.

 You got to make sure you remove that key from Gerrit/GitHub afterwards
 unless you never publish them publicly.

 To generate a temporary key, run the following (no need for passphrase):

    ssh-keygen -f foo
    cat foo.pub
    cat foo

 If we already have a keypair, you should see below what you need to copy
 in Gerrit.

_EOF_

echo ""
echo "Go to Gerrit, in your account SSH keys, make sure the following is present."
echo ""
echo ""
echo $id_rsa_pub
echo ""
echo ""
echo "IMPORTANT: do NOT keep this key on your account, delete it right after you are done with this script"
echo ""
echo ""

while true; do
    read -p "Did you add the public key in your SSH keys? (y/n): " yn
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes (y) or no (n).";;
    esac
done

echo $id_rsa_pub > /home/dhc-user/.ssh/id_rsa.pub


if [ ! -f "/etc/salt/grains" ]; then
clear
echo ""
echo "What is the deployment level of this cluster? Will it be used as the"
echo "new production, or its for development?"
echo ""

while true; do
    read -p "What is this salt-master targeted level? [staging,production,dev]: " level
    case $level in
        staging ) break;;
        production ) break;;
        dev ) break;;
        * ) echo "Only lowercase is accepted; one of [staging,production,dev].";;
    esac
done

## We are hardcoding the name "salt" here because we EXPLICTLY want that VM to be
## called that name.
echo " * Making sure the hosts file has 127.0.1.1 to declare our environment level"
sed -i "s/^127.0.1.1 $(hostname)/127.0.1.1 salt.${level}.wpdn salt/g" /etc/hosts
grep -q -e "salt" /etc/hosts || printf "127.0.1.1 salt.${level}.wpdn salt" >> /etc/hosts

(cat <<- _EOF_
# This salt master has been created on ${DATE}
# via new-salt-master.sh script
level: ${level}
_EOF_
) > /etc/salt/grains
  echo " * Added new grain; deployment level: ${level}"
else
  echo " * Grains already exist on this (future) salt master, did not overwrite"
fi



echo " * Making sure the name of the master is salt"
(cat <<- _EOF_
id: salt
log_level: debug
log_level_logfile: debug
_EOF_
) > /etc/salt/minion.d/overrides.conf



cd /srv

declare -A repos
declare -A options

repos["salt"]="ssh://renoirb@source.webplatform.org:29418/salt-states"
repos["private"]="ssh://renoirb@source.webplatform.org:29418/pillars-private"
repos["pillar"]="ssh://renoirb@source.webplatform.org:29418/pillars"
repos["runner"]="ssh://renoirb@source.webplatform.org:29418/runners"
repos["opsconfigs"]="ssh://renoirb@source.webplatform.org:29418/opsconfigs"

options["salt"]="--branch 201409-removing-private-data --origin gerrit --quiet"
options["private"]="--branch 201409-removing-private-data --origin gerrit --quiet"
options["pillar"]="--branch 201409-removing-private-data --origin gerrit --quiet"
options["runner"]="--origin gerrit --quiet"
options["opsconfigs"]="--quiet --origin gerrit"


echo "We will be cloning our new Salt master config repos:"

for key in ${!repos[@]}; do
    if [ ! -d "/srv/${key}/.git" ]; then
      echo " * Cloning into /srv/${key}"
      mkdir -p /srv/${key}
      chown dhc-user:dhc-user /srv/${key}
      (salt-call --local --log-level=quiet git.clone /srv/${key} ${repos[${key}]} opts="${options[${key}]}" user="dhc-user" identity="/home/dhc-user/.ssh/id_rsa")
    else
      echo " * Repo in /srv/${key} already cloned. Did nothing."
    fi
done

echo ''
echo "Done cloning config repos"
echo ""


echo "Configuring salt master for initial highstate"
if [ ! -f "/etc/salt/master.d/roots.conf" ]; then
(cat <<- _EOF_
# Set in place by new-saltmaster, this should be overwritten once you
# make state.highstate.
file_roots:
  base:
    - /srv/salt

pillar_roots:
  base:
    - /srv/pillar
    - /srv/private/pillar

log_level: debug
log_level_logfile: debug

gitfs_provider: dulwich

fileserver_backend:
  - roots
  - git

gitfs_remotes:
  - https://github.com/webplatform/saltstack-sysctl-formula.git
  - https://github.com/webplatform/postgres-formula.git

_EOF_
) > /etc/salt/master.d/roots.conf
  echo " * Added roots definitions"
  echo " * Syncing grains, pillars, states, returners, etc."
  salt-call --local --log-level=quiet saltutil.sync_all
else
  echo " * Salt-master roots was already present"
fi

echo "Restarting salt (almost there!)"

/usr/sbin/service salt-minion restart
/usr/sbin/service salt-master restart

echo "Autoaccepting salt"
salt-key -a salt

echo "Removing temporary SSH key"
echo -e "\e[31mDID YOU REMOVE the SSH key in Gerrit??\e[0m"

rm /home/dhc-user/.ssh/id_rsa{,.pub}

clear

echo ""
echo "Step 1 of 3 completed!"
echo ""
echo "Next steps, run:"
echo " salt-call --local state.highstate"
echo " bash /srv/salt/_utils/new-saltmaster-packages.sh"
echo ""

exit 0
