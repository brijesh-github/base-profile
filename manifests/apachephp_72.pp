class profile::apachephp_72 {

exec {'install-repo':
 command => '/bin/tar -xvf /etc/yum.repos.d/non-standard.tar.gz',
}

exec {'removephp':
 command => '/bin/yum -y remove php*'
}

class {'::php':
 ensure => '7'
}

class {'apache':
 }
class { 'apache::mod::php':
      package_name  =>  "php",
      php_version => '7'
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









