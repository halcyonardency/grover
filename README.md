grover
======

Puppet configs.  Because we care.

Tested on Fedora19 x86_64.

Pre-install
-------------

<code><pre>
rpm -ivh http://yum.puppetlabs.com/fedora/f19/products/i386/puppetlabs-release-19-2.noarch.rpm
yum -y install  git puppet
cd /opt/
git clone https://github.com/xyntrix/grover.git grover
sh ./go-grover.sh
</pre></code>
