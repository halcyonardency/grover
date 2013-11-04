class collectd::plugin::apache (
   $ensure = present,
   $instances  = { 'localhost' => { 'url' => 'http://localhost/mod_status?auto' } },
) {
   include collectd::params
   package { "collectd-apache":
      ensure => $collectd::plugin::apache::ensure,
   }

  $conf_dir = $collectd::params::plugin_conf_dir
  validate_hash($instances)

  file { 'apache.conf':
    ensure    => $collectd::plugin::apache::ensure,
    path      => "${conf_dir}/apache.conf",
    mode      => '0644',
    owner     => 'root',
    group     => 'root',
    content   => template('collectd/apache.conf.erb'),
    notify    => Service['collectd']
  }
}
