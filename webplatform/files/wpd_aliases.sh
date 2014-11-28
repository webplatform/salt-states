# Managed by salt stack
alias wpd-service-test='nc -vz '
alias wpd-netstat='netstat -tulpn'
alias wpd-gentoken='openssl rand -base64 32'
alias besu='sudo -H bash -l'
alias scr='screen -dd -R'

wpd-trailing-whitespace() {
  if [ -f "$1" ]; then
    sed -i 's/[ \t]*$//' "$1"
  fi
}

wpd-git-search-file() { 
  git log --all --name-only --pretty=format: | sort -u | grep "$1"
}
