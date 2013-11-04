Package { provider => "yum" }
Service { provider => systemd }


node default {
   class { 'vim': }
   class { 'screen': }
   class { 'denyhosts': }
   class { 'git': }
   class { 'apache': }
   class { 'apache::passenger': }
   class { 'sinatra': }
   class { 'collectd': }
   class { 'jwhois': }
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
