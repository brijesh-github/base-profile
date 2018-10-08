class profile::apachephp_71 {
  class {'apache':
    mpm_module => 'prefork',
    docroot    => "/var/www",
 }
class { 'apache::mod::php':
    package_name => 'php70',
    php_version  => '7.0',
    path         => 'modules/libphp-7.0.so',
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









