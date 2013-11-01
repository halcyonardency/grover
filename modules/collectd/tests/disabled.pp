# Class' service disabling
#
class { 'collectd':
  service_ensure => 'stopped',
  service_enable => false,
}
