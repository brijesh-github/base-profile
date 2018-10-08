class profile::phpc {

class { 'apache::mod::php':
  ensure => '70w',
}
}

