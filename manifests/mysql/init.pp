class profile::mysql::init
(
  String $version = 'old',
){

   wget::fetch { 'https://s3.us-east-2.amazonaws.com/com-presidio-mysql/initialize.sql':
    destination => '/tmp/',
    timeout     => 0,
    verbose     => false,
  }
   
  file { '/tmp/initialize.sql':
    ensure => present,
    source => '/tmp/initialize.sql',
  }
  
  if $version == 'old' {
    exec {'manage-repo':
      command => 'yum-config-manager --disable mysql80-community && yum-config-manager --enable mysql57-community',
      path    => ['/sbin', '/bin', '/usr/sbin', '/usr/bin'],
    }
    exec {'cleanup-version':
      command => 'yum -y remove -community-server-8.0',
      path    => ['/sbin', '/bin', '/usr/sbin', '/usr/bin'],
      unless  => 'rpm -qa | grep mysql-community-server-8.0',
    }
  } else {
    exec {'manage-repo':
      command => 'yum-config-manager --enable mysql80-community && yum-config-manager --disable mysql57-community',
      path    => ['/sbin', '/bin', '/usr/sbin', '/usr/bin'],
    }
    exec {'cleanup-version':
      command => 'yum -y remove mysql-community-server-5.7.23',
      path    => ['/sbin', '/bin', '/usr/sbin', '/usr/bin'],
      unless  => 'rpm -qa | grep mysql-community-server-5.7.23',
    }
  }
}
