#
# Testing configuration file provisioning via template
#
class { 'collectd':
  file_template => 'collectd/tests/test.conf',
}
