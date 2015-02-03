# WebPlatform server environment configuration

## Making a new salt-master

Send a copy of the `_utils/new-saltmaster.sh` to an empty Ubuntu 14.04 VM and run it as root.

Once you are there, you should be able to finish with the three next steps.

To have a fully functional salt master, run in the following order:

Run `_utils/new-saltmaster.sh` on new VM, and follow directions.

To deploy web apps, we are currently assuming that the salt master will host all the code repositories
along with the dependency management tools installed.

In order to allow us to have a VM to prepare each web app, the following has to be run on the salt master.
We will eventually create a VM specifically for that later in this project.


## Security groups configuration

All services that requires TCP/UDP connectivity should have, in the state file or
configuration file, an annotation about it.

To find all security groups that requires communication, search the files for notes
that contains `## SecurityGroup`.  This string can be as a comment, or at the end
of a configuration line.

For example, MediaWiki `Settings.php` has a line like this:

```php
$wpdUdp2logDest = 'salt:8420'; ## SecurityGroup port: UDP 8420 @salt demux.py
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



## Config stashes

* https://gist.github.com/renoirb/031667fa19062c773de5
* https://gist.github.com/renoirb/a66b533c46ef7a8de8e3
* https://gist.github.com/renoirb/11258261
* https://gist.github.com/renoirb/f90d0226d8882b50df0e


### Bookmarks

* https://github.com/wikimedia/operations-puppet/blob/production/modules/varnish/templates/vcl/wikimedia.vcl.erb
* https://github.com/wikimedia/operations-puppet/blob/production/manifests/role/redisdb.pp
* https://github.com/wikimedia/operations-puppet/blob/production/manifests/role/memcached.pp
* https://github.com/wikimedia/operations-puppet/blob/production/modules/nutcracker/manifests/init.pp

## Maintenance commands

Here are a few commands that can be done with Salt Stack.

Every commands here can be run manually.
Ideally there should be always a salt state to enforce anything permanent.
But sometimes we have to act quickly and update the states later.

1. Rewrite a setting in one config file

    salt app\* file.replace /etc/php5/apache2/php.ini pattern='expose_php = On' repl='expose_php = Off'

2. Get to know what are the grants for one user

    salt db\* mysql.user_grants accounts '%'

3. Reload apache2 config (or any service)

    salt app\* service.reload apache2

4. Can we write to the filesystem?

    salt bots cmd.run "touch /root/TestIfWeCabWrite && echo 'OK' || echo 'Writing to filesystem failed'"
    salt bots cmd.run "rm /root/TestIfWeCabWrite && echo 'OK' || echo 'Writing to filesystem failed'"

5. Upgrade Operating System packages (If it has a service, it’ll also handle its restart)

    salt app\* pkg.upgrade

6. Delete a user

    salt \* user.delete foobar remove=True force=True

