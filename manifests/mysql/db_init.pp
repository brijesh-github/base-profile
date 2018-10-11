class profile::mysql::db_init
(
 String $root_password,
) {
  
  $virt = $facts['mysql_installed']
  notify{'$virt':} 

  if( $facts['mysql_installed'] == 0){
    exec {'root-password-reset':
      command => 'mysqladmin --user=root --password= password $root_password',
      path => '/bin:/opt/puppetlabs/bin/facter',
    }
    exec {'initialize-database':
      command => 'mysql -u root --password= $root_password </tmp/initialize.sql',
      path => '/bin:/opt/puppetlabs/bin/facter',
    }
    exec {'set-environment':
      environment => ["FACTER_mysql_installed=1"],
      command => '/bin/echo FACTER_mysql_installed > /tmp/envs',
    } 
 }
}
