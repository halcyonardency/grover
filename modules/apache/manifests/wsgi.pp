# Class apache::wsgi
#
# Apache resources specific for wsgi
#
class apache::wsgi {

  include apache

  case $::operatingsystem {
    ubuntu,debian,mint: {
      package { 'libapache2-mod-wsgi':
        ensure => present;
      }

      exec { 'enable-wsgi':
        command => '/usr/sbin/a2enmod wsgi',
        creates => '/etc/apache2/mods-enabled/wsgi.load',
        notify  => Service['apache'],
        require => [
          Package['apache'],
          Package['libapache2-mod-wsgi']
        ],
      }
    }

    centos,redhat,scientific,fedora: {
      $osver = split($::operatingsystemrelease, '[.]')

    file { '10-wsgi.conf':
      ensure    => present,
      path      => "${apache::config_dir}/conf.modules.d/10-wsgi.conf",
      mode      => '0644',
      owner     => 'root',
      group     => 'root',
      content   => template('apache/wsgi.conf'),
    }

      package { 'mod_wsgi':
        ensure => present;
      }
    }

    default: { }
  }

}
