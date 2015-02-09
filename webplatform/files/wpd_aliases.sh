# Managed by salt stack

alias besu='sudo -H bash -l'
alias scr='screen -dd -R'

alias wpd-flavor="nova flavor-list"
alias wpd-secgroup="nova secgroup-list"
alias wpd-service-test='nc -vz '
alias wpd-netstat='netstat -tulpn'
alias wpd-gentoken='openssl rand -base64 32'

# ref: http://www.commandlinefu.com/commands/view/3543/show-apps-that-use-internet-connection-at-the-moment.
wpd-lsof-network-services() {
  lsof -P -i -n | cut -f 1 -d " "| uniq | tail -n +2
}

wpd-openssl-read() {
  openssl x509 -text -in $1 | more
}

wpd-lsof-socks(){
  lsof -P -i -n | less
}

wpd-lsof() {
  /usr/bin/lsof -w -l | less
}

wpd-trailing-whitespace() {
  if [ -f "$1" ]; then
    sed -i 's/[ \t]*$//' "$1"
  fi
}

# ref: http://stackoverflow.com/questions/26370185/how-do-criss-cross-merges-arise-in-git
wpd-git-log() {
  git log --graph --oneline --decorate --all
}

wpd-git-search-file() {
  git log --all --name-only --pretty=format: | sort -u | grep "$1"
}

# ref: http://hardenubuntu.com/disable-services
alias wpd-processes="initctl list | grep running"

alias wpd-connections="netstat -ntu | awk '{print $5}' | cut -d: -f1 | sort | uniq -c | sort -n"

wpd-deploy () { echo "Going to update roles for:"; sudo salt -G "roles:$@" grains.get roles; echo "Deploying..."; sudo salt -G "roles:$@" state.sls code; }
wpd-salt-events () { echo "About to dump events to stdout"; sudo salt-run state.event | while read -r tag data; do echo $tag; echo $data | jq -C .; done; }

#python -c 'import sys, yaml, json; json.dump(yaml.load(sys.stdin), sys.stdout, indent=2)' < foo.yaml > foo.json
#python -c 'import sys, yaml, json; yaml.safe_dump(json.load(sys.stdin),sys.stdout,allow_unicode=True,default_flow_style=False)' < foo.json > foo.yaml

