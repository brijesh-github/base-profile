class profile::tomcat {
  class { 'java': }
    tomcat::install { '/opt/tomcat9':
    source_url => "https://s3.us-east-2.amazonaws.com/com-presidio-tomcat/apache-tomcat-9.0.12.tar.gz",
  }
  tomcat::instance { 'default':
    catalina_home => '/opt/tomcat9',
  }
  tomcat::war { 'db.war':
    catalina_base => '/opt/tomcat9',
    war_source    => 'https://s3.us-east-2.amazonaws.com/com-presidio-tomcat/db.war',
  }
}





