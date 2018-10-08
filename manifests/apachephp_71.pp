class profile::apachephp_71 {
  class {'apache':
    mpm_module => 'prefork',
 }

exec { 'removephp' :
  command => '/bin/yum remove -y php*'
}
class { 'apache::mod::php':
     package_name => 'php56w',
  }

wget::fetch { 'https://s3.us-east-2.amazonaws.com/com-presidio-puppet-php/index.php':
  destination => '/var/www/html/',
  timeout     => 0,
  verbose     => false,
}

 file { "/var/www/html/index.php":
  ensure => file,
  owner  => "root",
  group  => "root",
  mode   => "0755",
 }
}









