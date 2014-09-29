
## Connecting with SSH

Not ALL VMs in an environment has a publicly available IP address. To connect
to them, you have to configure your local SSH client to use the salt master as
a proxy.

SSHing to a VM is done in the following way:

    ssh app1.staging.wpdn

The app1.staging.wdpn is visible from the salt master through either a hosts file
entry or a local DNS server but your own local machine cannot see it. This is
where your local SSH config comes into play.

The only thing you need to do is to add to your ~/.ssh/config the following:

    ## Use salt as a Jumb box
    ##
    ## Reference:
    ##   - http://serverfault.com/questions/337274

    Host staging.wpdn
      Hostname salt.webplatformstaging.org
      ProxyCommand none

    Host *.staging.wpdn
      ProxyCommand ssh -e @ -o StrictHostKeyChecking=no -a -W %h:%p staging.wpdn
