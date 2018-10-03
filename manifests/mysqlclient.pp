class profile::mysqlclient {

  class { 'mysql_java_connector':
    links  => [ '/opt/tomcat9/lib' ]
  }

}
