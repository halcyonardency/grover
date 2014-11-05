grover
======

Puppet configs.  Because we care.

Tested on Fedora19 x86_64.   

This is a masterless Puppet repository.  

This collection allows you to quickly and simply spin up a virtual or bare metal host for development as well as  production use.

Stupid Simple Install Steps
-------------

<code><pre>
rpm -ivh http://yum.puppetlabs.com/fedora/f19/products/i386/puppetlabs-release-19-2.noarch.rpm
yum -q -y install  git puppet
git clone https://github.com/xyntrix/grover.git /opt/grover
time sh /opt/grover/go-grover.sh
</pre></code>



Kick-ass Components
-------------
- General packages:  vim, screen, git, puppet, jwhois
- Denyhosts: Block brute force sources
- Apache 2.4, mod_passenger (Ruby), mod_wsgi (Python)
- Ruby 2.0, Sinatra Gem
- Collectd, Collectd-Web, Apache Plugin, Puppet Reports Plugin
- Graphite (carbon-cache, carbon-relay, graphite-web)
- Sensu (master and client), +ability to add a sensu-check/sensu-subscriber within any puppet class
- Firewall, +ability to add firewall rules within any puppet class
- Puppet utility classes: Puppi (example42), Stdlib (puppetlabs)


Digital Ocean Test Run: All Components
-------------
Notice: Finished catalog run in 253.50 seconds

real    4m18.036s
user    3m17.684s
sys     0m13.328s

TODO Next
-------------
- Redis
- RabbitMQ :: server, vhost, creds

