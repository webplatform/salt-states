# WebPlatform server environment configuration


## Security groups configuration

All services that requires TCP/UDP connectivity should have, in the state file or
configuration file, an annotation about it.

To find all security groups that requires communication, search the files for notes
that contains `## SecurityGroup`.  This string can be as a comment, or at the end
of a configuration line.

For example, MediaWiki `Settings.php` has a line like this:

```php
$wpdUdp2logDest = 'salt.local.wpdn:8420'; ## SecurityGroup port: UDP 8420 @salt demux.py
```

All security groups are expected to allow local network communication exclusively by allowing
only incoming traffic from `10.10.10.0/24` or any other local network IP class available.

As for inter network communication, we should maintain explicitly which security groups are allowing
outside communication.


## Connecting with SSH

Not ALL VMs in an environment has a publicly available IP address. To connect
to them, you have to configure your local SSH client to use the salt master as
a proxy. SSHing to a VM is done in the following way:

    ssh app1.staging.wpdn

The app1.staging.wdpn is visible from the salt master through either a hosts file
entry or a local DNS server but your own local machine cannot see it. This is
where your local SSH config comes into play.

To access them, add to your `~/.ssh/config`:

    ## Use salt as a Jump box
    ##
    ## Reference:
    ##   - http://serverfault.com/questions/337274
    ##   - https://wikitech.wikimedia.org/wiki/Help:Access#Using_ProxyCommand_ssh_option
    ##   - http://blog.pluralsight.com/linux-ssh-jumpbox
    Host staging.wpdn
      Hostname salt.webplatformstaging.org
      ProxyCommand none
    Host *.staging.wpdn
      ProxyCommand ssh -e @ -o StrictHostKeyChecking=no -a -W %h:%p staging.wpdn


