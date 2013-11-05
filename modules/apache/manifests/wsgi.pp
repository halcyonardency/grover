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

      package { 'mod_wsgi':
        ensure => present;
      }
    }

    default: { }
  }

}
