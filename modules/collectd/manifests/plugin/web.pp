class collectd::plugin::web (
   $ensure = present,
) {
   include collectd::params
   package { "collectd-web":
      ensure => $collectd::plugin::web::ensure,
   }

#  $conf_dir = $collectd::params::plugin_conf_dir
#  file { 'web-collectdion.conf':
#    ensure    => $collectd::plugin::web::ensure,
#    path      => "/etc/httpd/conf.d/collectd.conf",
#    mode      => '0644',
#    owner     => 'root',
#    group     => 'root',
#    content   => template('collectd/collectd-web.conf.erb'),
#  }
}
