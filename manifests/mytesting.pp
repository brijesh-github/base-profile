class profile::mytesting{

class { '::mysql::server' :
    service_name     => 'mysqld',
    root_password    => 'newpassword',
    package_name     => 'mysql-community-server',
    create_root_user => '0.0.0.0',
    restart => true,
    override_options => {
      mysqld => {
        log-error => '/var/log/mysqld.log',
        pid-file  => '/var/run/mysqld/mysqld.pid',
        default_authentication_plugin=>'mysql_native_password',
        bind-address => $bind_address,
      },
      mysqld_safe => {
        log-error => '/var/log/mysqld.log',
      },
    },
  }

}



