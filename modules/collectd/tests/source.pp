#
# Testing configuration file provisioning via source
#
class { 'collectd':
  file_source => 'puppet:///modules/collectd/tests/test.conf',
}
