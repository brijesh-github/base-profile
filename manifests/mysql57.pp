class profile::mysql57(
$secret_file = '/.mysql_secret'
){

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
  command => '/bin/yum-config-manager --disable mysql80-community'
}

exec{'disable-57-repo':
  command => '/bin/yum-config-manager --enable mysql57-community'
}

exec{'uninstall-previous-versions':
 command => '/bin/yum -y remove mysql'
}

package { 'mysql-community-server':
   name      => 'mysql-community-server',
   ensure    => installed,
   install_options => {'mysqld' => {'max_connections' => '1025', 'bind_address' => '0.0.0.0'}},
}

  $rm_pass_cmd = join([
    "mysqladmin -u root --password=\$(grep -o '[^ ]\\+\$' ${secret_file}) password ''",
    "rm -f ${secret_file}"
  ], ' && ')
  exec { 'remove install pass':
    command => $rm_pass_cmd,
    onlyif  => "test -f ${secret_file}",
    path    => '/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin'
  }


service { 'mysqld':
  ensure => 'running'
}

#exec{'create-db-user':
# command => '/bin/mysql -u root  < /tmp/initialize.sql'
#}

}
