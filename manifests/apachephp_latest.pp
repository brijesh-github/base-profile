class profile::apachephp_latest {

 package { 'php':
  ensure => 'latest',
 }

  class {'apache':
    mpm_module => 'prefork',
    docroot    => "/var/www",
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









