Package { provider => "yum" }
Service { provider => systemd }


node default {
   class { 'vim': }
   class { 'screen': }
   class { 'denyhosts': }
   class { 'git': }
   class { 'apache': }
   class { 'apache::passenger': }
   class { 'apache::wsgi': }
   class { 'sinatra': }
   class { 'collectd': }
   class { 'collectd::plugin::apache': }
   class { 'collectd::plugin::web': }
   class { 'collectd::plugin::puppet-reports': }
   class { 'jwhois': }
   class { 'graphite': 
      gr_max_cache_size => 256,
      gr_enable_udp_listener => True,
      gr_apache_port => 2080,
      gr_apache_port_https => 2443,
   }
   #class { 'collectd::apache': }
   resources { "firewall":
      purge => true
   }
   Firewall {
      before  => Class['default_fw::post'],
      require => Class['default_fw::pre'],
   }
   class { ['default_fw::pre', 'default_fw::post']: }
   class { 'firewall': }
   firewall { "00080 open tcp ports 22, 80, 443":
     proto => "tcp",
     dport => [22, 80, 443], 
     action => "accept"
   }

#   class { 'sensu':
#     rabbitmq_password  => 'secret',
#     rabbitmq_host      => 'sensu-server.foo.com',
#     subscriptions      => 'sensu-test',
#   }
}
