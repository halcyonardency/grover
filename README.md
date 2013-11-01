grover
======

Puppet configs.  Because we care.

Tested on Fedora19 x86_64.

Pre-install
-------------
<code>
yum -y install denyhosts git
systemctl start denyhosts.service
rpm -ivh http://yum.puppetlabs.com/fedora/f19/products/i386/puppetlabs-release-19-2.noarch.rpm
mkdir -p /opt/grover
cd /opt/grover
git clone git@github.com:xyntrix/grover.git grover
</code>
