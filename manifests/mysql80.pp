class profile::mysql80{

wget::fetch { 'https://s3.us-east-2.amazonaws.com/com-presidio-mysql/initialize.sql':
  destination => '/tmp/',
  timeout     => 0,
  verbose     => false,
}

wget::fetch { 'https://s3.us-east-2.amazonaws.com/com-presidio-mysql/server.cnf':
  destination => '/tmp/',
  timeout     => 0,
  verbose     => false,
}

exec {'enable-80-repo':
  command => '/bin/yum-config-manager --enable mysql80-community'
}

exec{'disable-57-repo':
  command => '/bin/yum-config-manager --disable mysql57-community'
}

exec{'uninstall-previous-versions':
 command => '/bin/yum -y remove mysql'
}

package { 'mysql-community-server':
   name      => 'mysql-community-server',
    ensure    => installed,
}

exec{'bind-address':
 command => '/bin/cp  /tmp/server.cnf /etc/my.cnf.d/'
}

service { 'mysqld':
  ensure => 'running'
}


exec{'create-db-user':
 command => '/bin/mysql -u root  < /tmp/initialize.sql'
}

}
   

