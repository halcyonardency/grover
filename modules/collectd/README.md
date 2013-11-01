# Puppet module: collectd

This is a Puppet module for collectd.
It manages its installation, configuration and service.

The module is based on stdmod naming standars.
Refer to http://github.com/stdmod/

Released under the terms of Apache 2 License.

Written by Alessandro Franceschi / Lab42


## USAGE - Basic management

It you are using Puppet version 3 or above all the parameters shown here can be set in Hiera as collectd::parameter

* Install collectd with default settings (package installed, service started, default configuration files)

        class { 'collectd': }

* Remove collectd package and purge all the managed files

        class { 'collectd':
          ensure => absent,
        }

* Install a specific version of collectd package

        class { 'collectd':
          version => '1.0.1',
        }

* Install the latest version of collectd package

        class { 'collectd':
          version => 'latest',
        }

* Enable collectd service. This is default.

        class { 'collectd':
          service_ensure => 'running',
        }

* Enable collectd service at boot. This is default.

        class { 'collectd':
          service_status => 'enabled',
        }


* Do not automatically restart services when configuration files change (Default: Class['collectd::config']).

        class { 'collectd':
          service_subscribe => false,
        }


## USAGE - Overrides and Customizations
* Use custom source for main configuration file

        class { 'collectd':
          file_source => [ "puppet:///modules/example42/collectd/collectd.conf-${hostname}" ,
                           "puppet:///modules/example42/collectd/collectd.conf" ],
        }


* Use custom source directory for the whole configuration dir.

        class { 'collectd':
          dir_source  => 'puppet:///modules/example42/collectd/conf/',
        }

* Use custom source directory for the whole configuration dir purging all the local files that are not on the dir.
  Note: This option can be used to be sure that the content of a directory is exactly the same you expect, but it may be dangerous as it may remove files on the target system.

        class { 'collectd':
          dir_source => 'puppet:///modules/example42/collectd/conf/',
          dir_purge  => true, # Default: false.
        }

* Use custom source directory for the whole configuration dir and define recursing policy.

        class { 'collectd':
          dir_source    => 'puppet:///modules/example42/collectd/conf/',
          dir_recursion => false, # Default: true.
        }

* Use custom template for main config file. Note that template and source arguments are alternative.

        class { 'collectd':
          file_template => 'example42/collectd/collectd.conf.erb',
        }

* Use a custom template and provide an hash of custom configurations that you can use inside the template

        class { 'collectd':
          filetemplate       => 'example42/collectd/collectd.conf.erb',
          file_options_hash  => {
            opt  => 'value',
            opt2 => 'value2',
          },
        }


* Specify the name of a custom class to include that provides the dependencies required by the module

        class { 'collectd':
          dependency_class => 'site::collectd_dependency',
        }


* Automatically include a custom class with extra resources related to collectd.
  Here is loaded $modulepath/example42/manifests/my_collectd.pp.
  Note: Use a subclass name different than collectd to avoid order loading issues.

        class { 'collectd':
         my_class => 'site::collectd_my',
        }

## TESTING
[![Build Status](https://travis-ci.org/example42/puppet-collectd.png?branch=master)](https://travis-ci.org/example42/puppet-collectd)
