class profile::tomcat8 {
  class { 'java': }
    tomcat::install { '/opt/tomcat8':
    source_url => "https://s3.us-east-2.amazonaws.com/com-presidio-tomcat/apache-tomcat-8.5.34.tar.gz",
  }
  tomcat::instance { 'default':
    catalina_home => '/opt/tomcat8',
  }
tomcat::service { 'tomcat-9':
    catalina_home => '/opt/tomcat9',
    catalina_base => '/opt/tomcat9',
    service_ensure => false,
  }
tomcat::service { 'tomcat-8':
    catalina_home => '/opt/tomcat8',
    catalina_base => '/opt/tomcat8', 
    service_ensure => true,
  }


  tomcat::war { 'db.war':
    catalina_base => '/opt/tomcat8',
    war_source    => 'https://s3.us-east-2.amazonaws.com/com-presidio-tomcat/db.war',
  }
}
