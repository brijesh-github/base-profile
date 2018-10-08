class profile::mysql8 {

   package { 'mysql-community-repo':
      name      => 'mysql-community-server',
      ensure    => installed,
    }

  class { '::mysql::server' :
    root_password    => '1L0v3Ic3Cr3am#!',
    override_options =>  {'mysqld' => {'max_connections' => '1025', 'bind_address' => '0.0.0.0'}},
    restart =>true, 
    require         => Package['mysql-community-repo'],
    datadir         => '/var/lib/mysql',
    socket          => '/var/lib/mysql/mysql.sock', 
}

}	
