Package { provider => "yum" }
Service { provider => systemd }

node default {
   class { 'vim': }
   class { 'screen': }
   class { 'denyhosts': }
   class { 'git': }
   resources { "firewall":
      purge => true
   }
   class { 'firewall': }
#   class { 'sensu':
#     rabbitmq_password  => 'secret',
#     rabbitmq_host      => 'sensu-server.foo.com',
#     subscriptions      => 'sensu-test',
#   }
}
