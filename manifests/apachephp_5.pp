class profile::apachephp_5 {
  class {'apache':
    mpm_module => 'prefork',
 }
class { 'apache::mod::php':
   }
wget::fetch { 'https://s3.us-east-2.amazonaws.com/com-presidio-puppet-php/index.php':
  destination => '/var/www/html',
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









