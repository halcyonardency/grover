class collectd::plugin::puppet-reports (
   $ensure = present,
) {
   include collectd::params
   $conf_dir = $collectd::params::plugin_conf_dir

   package { "PyYAML":
      ensure => $collectd::plugin::apache::ensure,
   }

  file { 'puppet-reports.py':
    ensure    => $collectd::plugin::apache::ensure,
    path      => "/usr/lib/collectd/puppet_reports.py",
    mode      => '0755',
    owner     => 'root',
    group     => 'root',
    content   => "puppet:///modules/collectd/puppet_reports.py",
    notify    => Service['collectd']
  }

  file { '10-puppet-reports.conf':
    ensure    => $collectd::plugin::apache::ensure,
    path      => "${conf_dir}/puppet-reports.conf",
    mode      => '0644',
    owner     => 'root',
    group     => 'root',
    content   => template('collectd/puppet-reports.conf.erb'),
    notify    => Service['collectd']
  }
}
