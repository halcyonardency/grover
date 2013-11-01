# Class: collectd::params
#
# Defines all the variables used in the module.
#
class collectd::params {

  $package_name = $::osfamily ? {
    default => 'collectd',
  }

  $service_name = $::osfamily ? {
    default => 'collectd',
  }

  $file_path = $::osfamily ? {
    RedHat  => '/etc/collectd.conf',
    default => '/etc/collectd/collectd.conf',
  }

  $file_mode = $::osfamily ? {
    default => '0644',
  }

  $file_owner = $::osfamily ? {
    default => 'root',
  }

  $file_group = $::osfamily ? {
    default => 'root',
  }

  $dir_path = $::osfamily ? {
    default => '/etc/collectd',
  }

}
