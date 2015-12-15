# Managed by salt stack
# {{ source }}

alias wpd-flavor="nova flavor-list"
alias wpd-secgroup="nova secgroup-list"
alias wpd-service-test='nc -vz '
alias wpd-nova-active='nova list --fields name,Networks --status ACTIVE'

wpd-deploy () { echo "Going to update roles for:"; sudo salt -G "roles:$@" grains.get roles; echo "Deploying..."; sudo salt -G "roles:$@" state.sls code; }
wpd-salt-events () { echo "About to dump events to stdout"; sudo salt-run state.event | while read -r tag data; do echo $tag; echo $data | jq -C .; done; }

#python -c 'import sys, yaml, json; json.dump(yaml.load(sys.stdin), sys.stdout, indent=2)' < foo.yaml > foo.json
#python -c 'import sys, yaml, json; yaml.safe_dump(json.load(sys.stdin),sys.stdout,allow_unicode=True,default_flow_style=False)' < foo.json > foo.yaml
