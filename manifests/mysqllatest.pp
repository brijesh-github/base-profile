class profile::mysqllatest {

  include ::profile::base
  $rootPassword = 'webWorld123$';

  wget::fetch { 'https://s3.us-east-2.amazonaws.com/com-presidio-mysql/initialize.sql':
    destination => '/tmp/',
    timeout     => 0,
    verbose     => false,
  }

  file { '/tmp/initialize.sql':
    ensure => present,
    source => '/tmp/initialize.sql',
  }

  packagel-server':
    ensure => 'absent'
  }

  class { '::mysql::server' :
    root_password    => 'webWorld123$',
    service_name => 'mysqld',
    create_root_user => false,
    override_options => {
      mysqld => {
        log-error => '/var/log/mysqld.log',
        pid-file  => '/var/run/mysqld/mysqld.pid',
        default_authentication_plugin=>'mysql_native_password',
      },
      mysqld_safe => {
        log-error => '/var/log/mysqld.log',
      },
    },
    restart =>true, 
    package_name => 'mysql-community-server',
}

exec {'root-password-reset':
  command => 'mysqladmin --user=root --password= password ${root_password}',
  path => '/bin',
  unless => 'mysql -u root --password=""',
}

exec {'initialize-database':
  command => 'mysql -u root --password= ${root_password} </tmp/initialize.sql',
  path => '/bin',
  unless => 'mysql -u root --password=""',
}

}	
