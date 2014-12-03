# Managed by salt stack
alias wpd-service-test='nc -vz '
alias wpd-netstat='netstat -tulpn'
alias wpd-gentoken='openssl rand -base64 32'
alias besu='sudo -H bash -l'
alias scr='screen -dd -R'

# ref: http://www.commandlinefu.com/commands/view/3543/show-apps-that-use-internet-connection-at-the-moment.
wpd-lsof-network-services() {
  lsof -P -i -n | cut -f 1 -d " "| uniq | tail -n +2
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

wpd-git-search-file() { 
  git log --all --name-only --pretty=format: | sort -u | grep "$1"
}
