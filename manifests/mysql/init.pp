class profile::mysql::init
(
  String $version = 'old',
){
   wget::fetch { 'https://s3.us-east-2.amazonaws.com/com-presidio-mysql/initialize.sql':
    destination => '/tmp/',
    timeout     => 0,
    verbose     => false,
  }
  file { '/tmp/initialize.sql':
    ensure => present,
    source => '/tmp/initialize.sql',
  }
  if $version == 'old' {
    exec {'manage-repo':
      command => 'yum-config-manager --disable mysql80-community && yum-config-manager --enable mysql57-community',
      path    => ['/sbin', '/bin', '/usr/sbin', '/usr/bin'],
    }
    exec {'cleanup-version':
      command => 'yum -y remove mysql-community-libs-8.0.12-1.el7.x86_64 mysql-community-server-8.0.12-1.el7.x86_64 mysql-community-common-8.0.12-1.el7.x86_64 mysql-community-client-8.0.12-1.el7.x86_64  && rm -rf /var/lib/mysql/ && rm -rf /root/.my.cnf && yum clean all && sleep 2 ',
      path    => ['/sbin', '/bin', '/usr/sbin', '/usr/bin'],
      onlyif  => 'rpm -qa | grep mysql-community-server-8.0.12-1.el7.x86_64',
    }
    #exec {'install-mysql':
    #  command => '/bin/yum -d 0 -e 0 -y install mysql-community-server',
    #  path    => ['/sbin', '/bin', '/usr/sbin', '/usr/bin'],
    #  unless  => 'rpm -qa | grep mysql-community-server-5.7.23-1.el7.x86_64',
    #}
  } else {
    exec {'manage-repo':
      command => 'yum-config-manager --enable mysql80-community && yum-config-manager --disable mysql57-community',
      path    => ['/sbin', '/bin', '/usr/sbin', '/usr/bin'],
    }
    exec {'cleanup-version':
      command => 'yum -y remove ql-community-common-5.7.23-1.el7.x86_64 mysql-community-client-5.7.23-1.el7.x86_64 mysql-community-libs-5.7.23-1.el7.x86_64 mysql-community-server-5.7.23-1.el7.x86_64 && rm -rf /var/lib/mysql/ && rm -rf /root/.my.cnf && yum clean all && sleep 2 ',
      path    => ['/sbin', '/bin', '/usr/sbin', '/usr/bin'],
      onlyif  => 'rpm -qa | grep mysql-community-server-5.7.23-1.el7.x86_64',
    }
    #exec {'install-mysql':
    #  command => '/bin/yum -d 0 -e 0 -y install mysql-community-server',
    #  path    => ['/sbin', '/bin', '/usr/sbin', '/usr/bin'],
    #  unless  => 'rpm -qa | grep mysql-community-server-8.0.12-1.el7.x86_64',
    #}
  }
}
