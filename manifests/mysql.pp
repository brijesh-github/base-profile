class profile::mysql
(
  String $service_name  = 'mysqld',
  String $package_name  = 'mysql-community-server',
  String $root_password = 'password123$',
  String $bind_address  = '0.0.0.0',
  String $version = 'old',
) {
  class {'::profile::mysql::init':
    version => $version;
  }
  class {'::profile::mysql::server':
    service_name => $service_name,
    package_name => $package_name,
    root_password => $root_password,
    bind_address => $bind_address,	
  }
  class {'::profile::mysql::db_init':
    root_password => $root_password,
    installed => $::mysql_installed,
  }
}	
