class profile::mysql8 {

exec {'stop-mysql':
 command => '/sbin/service mysqld stop'
}

exec {'uninstall-previous-versions':
 command => '/bin/yum -y remove mysql'
}

  wget::fetch { 'https://s3.us-east-2.amazonaws.com/com-presidio-mysql/initialize.sql':
    destination => '/tmp/',
    timeout     => 0,
    verbose     => false,
  }

  file { '/tmp/initialize.sql':
    ensure => present,
    source => '/tmp/initialize.sql',
  }
#package { 'mysql57-community-release':
 #     name      => 'mysql55-community-release',
  #    ensure    => installed,
   # }

  class { '::mysql::server' :
    root_password    => '1L0v3Ic3Cr3am#!',
    override_options =>  {'mysqld' => {'max_connections' => '1025', 'bind_address' => '127.0.0.1', 'datadir' =>'/var/lib/mysql', 'pid-file' =>'/var/run/mysqld/mysqld.pid', 'socket'       => '/var/lib/mysql/mysql.sock', 'log-error' =>'/var/log/error.log', 'performance_schema' => 'OFF' }},
    restart =>true, 
 #   after         =>        Exec['uninstall-previous-versions'],
     package_name            => 'mysql-community-server',

}

exec {'start-mysql':
 command => '/sbin/service mysqld start'
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
