Package { provider => "yum" }
Service { provider => systemd }

node default {
   include vim
   include screen
   include denyhosts
   include git
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
