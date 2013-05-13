#secondary namenode class
class cdh3::hadoop::secondarynamenode inherits cdh3::hadoop {

  package {'hadoop-0.20-secondarynamenode':
    ensure  => installed,
    name    => 'hadoop-0.20-secondarynamenode',
    require => Package['jdk'],
  }
  service { 'hadoop-secondarynamenode':
    ensure     => running,
    name       => 'hadoop-0.20-secondarynamenode',
    hasstatus  => true,
    hasrestart => true,
    require    => Package['hadoop-0.20-secondarynamenode'],
  }
}
