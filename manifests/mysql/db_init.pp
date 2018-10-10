class profile::mysql::db_init
(
 String $root_password
) {
  exec {'root-password-reset':
    command => 'mysqladmin --user=root --password= password $root_password',
    path => '/bin',
  }
  exec {'initialize-database':
    command => 'mysql -u root --password= $root_password </tmp/initialize.sql',
    path => '/bin',
  }
}
