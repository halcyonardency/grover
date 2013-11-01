Package { provider => "rpm" }
Service { provider => systemd }

node default {
   include vim
   include denyhosts
   include git
}
