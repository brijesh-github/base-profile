class profile::mysql::db_init
(
 String $root_password,
 $installed,
) {
  if( $installed == false ){
    exec {'root-password-reset':
      command => 'mysqladmin --user=root --password= password $root_password',
      path => '/bin:/opt/puppetlabs/bin/facter',
    }
    exec {'initialize-database':
      command => 'mysql -u root --password= $root_password </tmp/initialize.sql',
      path => '/bin:/opt/puppetlabs/bin/facter',
    }
 }
}
