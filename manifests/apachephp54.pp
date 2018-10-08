class profile::apachephp54 {

exec {'remove-repo':
 command => '/bin/rm -rf /etc/yum.repos.d/web*.* /etc/yum.repos.d/remi*.* /etc/yum.repos.d/epel*.*',
}

exec {'removephp':
 command => '/bin/yum -y remove php*'
}

class {'::php':
 ensure => '5'
}
 class {'apache':
    docroot    => "/var/www",
 }
 class {'apache::mod::php':
  php_version => '5'   
}

wget::fetch { 'https://s3.us-east-2.amazonaws.com/com-presidio-puppet-php/index.php':
  destination => '/var/www/',
  timeout     => 0,
  verbose     => false,
}

 file { "/var/www/index.php":
  ensure => file,
  owner  => "root",
  group  => "root",
  mode   => "0755",
 }
}









