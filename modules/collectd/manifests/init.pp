# = Class: collectd
#
# This class installs and manages collectd
#
#
# == Parameters
#
# Refer to https://github.com/stdmod for the official
# documentation for standard parameters usage.
#
class collectd (

  $ensure                = 'present',
  $version               = undef,

  $package_name          = $collectd::params::package_name,

  $service_name          = $collectd::params::service_name,
  $service_ensure        = 'running',
  $service_enable        = true,

  $file_path             = $collectd::params::file_path,
  $file_replace          = $collectd::params::file_replace,
  $file_require          = 'Package[collectd]',
  $file_notify           = 'Service[collectd]',
  $file_source           = undef,
  $file_template         = undef,
  $file_content          = undef,
  $file_options_hash     = undef,

  $dir_path              = $collectd::params::dir_path,
  $dir_source            = undef,
  $dir_purge             = false,
  $dir_recurse           = true,

  $dependency_class      = undef,
  $my_class              = undef,

  $monitor_class         = undef,
  $monitor_options_hash  = { } ,

  $firewall_class        = undef,
  $firewall_options_hash = { } ,

  $scope_hash_filter     = '(uptime.*|timestamp)',

  $port                  = '25826',
  $protocol              = 'tcp',

  ) inherits collectd::params {


  # Input parameters validation

  validate_re($ensure, ['present','absent'], 'Valid values: present, absent.')
  validate_bool($service_enable)
  validate_bool($dir_recurse)
  validate_bool($dir_purge)
  if $file_options_hash { validate_hash($file_options_hash) }
  if $monitor_options_hash { validate_hash($monitor_options_hash) }
  if $firewall_options_hash { validate_hash($firewall_options_hash) }


  #Calculation of variables used in the module

  $file_owner          = $collectd::params::file_owner
  $file_group          = $collectd::params::file_group
  $file_mode           = $collectd::params::file_mode

  if $file_content {
    $managed_file_content = $file_content
  } else {
    if $file_template {
      $managed_file_content = template($file_template)
    } else {
      $managed_file_content = undef
    }
  }

  if $version {
    $managed_package_ensure = $version
  } else {
    $managed_package_ensure = $ensure
  }

  if $ensure == 'absent' {
    $managed_service_enable = undef
    $managed_service_ensure = stopped
    $dir_ensure = absent
    $file_ensure = absent
  } else {
    $managed_service_enable = $service_enable
    $managed_service_ensure = $service_ensure
    $dir_ensure = directory
    $file_ensure = present
  }


  # Resources Managed

  if $collectd::package_name {
    package { $collectd::package_name:
      ensure   => $collectd::managed_package_ensure,
    }
  }

  if $collectd::service_name {
    service { $collectd::service_name:
      ensure     => $collectd::managed_service_ensure,
      enable     => $collectd::managed_service_enable,
    }
  }

  if $collectd::file_path {
    file { 'collectd.conf':
      ensure  => $collectd::file_ensure,
      path    => $collectd::file_path,
      mode    => $collectd::file_mode,
      owner   => $collectd::file_owner,
      group   => $collectd::file_group,
      source  => $collectd::file_source,
      content => $collectd::managed_file_content,
      notify  => $collectd::file_notify,
      require => $collectd::file_require,
    }
  }

  if $collectd::dir_source {
    file { 'collectd.dir':
      ensure  => $collectd::dir_ensure,
      path    => $collectd::dir_path,
      source  => $collectd::dir_source,
      recurse => $collectd::dir_recurse,
      purge   => $collectd::dir_purge,
      force   => $collectd::dir_purge,
      notify  => $collectd::file_notify,
      require => $collectd::file_require,
    }
  }


  # Extra classes

  if $collectd::dependency_class {
    include $collectd::dependency_class
  }

  if $collectd::my_class {
    include $collectd::my_class
  }

  if $collectd::monitor_class {
    class { $collectd::monitor_class:
      options_hash => $collectd::monitor_options_hash,
      scope_hash   => inline_template("<%= scope.to_hash.reject { |k,v| k.to_s =~ /${scope_hash_filter}/ } %>"),
    }
  }

  if $collectd::firewall_class {
    class { $collectd::firewall_class:
      options_hash => $collectd::firewall_options_hash,
      scope_hash   => inline_template("<%= scope.to_hash.reject { |k,v| k.to_s =~ /${scope_hash_filter}/ } %>"),
    }
  }

}
