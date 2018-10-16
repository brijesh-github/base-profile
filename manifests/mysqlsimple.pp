class profile::mysqlsimple {

  wget::fetch { 'https://s3.us-east-2.amazonaws.com/com-presidio-mysql/initialize.sql':
    destination => '/tmp/',
    timeout     => 0,
    verbose     => false,
  }

  file { '/tmp/initialize.sql':
    ensure => present,
    source => '/tmp/initialize.sql',
  }

  class { '::mysql::server' :
   service_name => 'mysqld',
    package_name => 'mysql-community-server',
    package_ensure          => '5.7*',
    root_password    => '1L0v3Ic3Cr3am#!',
    override_options =>  {'mysqld' => {'max_connections' => '1025', 'bind_address' => '0.0.0.0', 'log-error' => '/var/log/mysqld.log'}},
    restart =>true,  
}

  mysql::db { 'jpetstore' :
    user => 'admin',
    password => '1L0v3Ic3Cr3am#!',
    host => '%',
    sql => '/tmp/initialize.sql',
    require => File['/tmp/initialize.sql'],
}

  mysql_user { 'jpetstore@localhost':
    ensure => 'present',
    max_connections_per_hour => '60',
    max_queries_per_hour => '60',
    max_updates_per_hour => '120',
    max_user_connections => '10',
  }
}	
