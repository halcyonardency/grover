Package { provider => "rpm" }
Service { provider => systemd }

node default {
   include vim
   include screen
   #include denyhosts
   include git
}
