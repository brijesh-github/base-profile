class profile::mysql::server(
  String $service_name  = 'mysqld',
  String $package_name  = 'mysql-community-server',
  String $root_password = 'newPassword123',
  String $bind_address  = '0.0.0.0',
){
  notice('before profile::mysql::server')
  class { '::mysql::server' :
    service_name     => $service_name,
    root_password    => $root_password,
    package_name     => $package_name, 
    create_root_user => false,
    restart => false,
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
  notice('after profile::mysql::server')
}
