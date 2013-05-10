#Hadoop datanode class
class cdh3::hadoop::datanode inherits cdh3::hadoop {
  package {'hadoop-0.20-datanode':
    ensure => installed,
    name   => 'hadoop-0.20-datanode',
  }

  service { 'hadoop-datanode':
    ensure     => running,
    name       => 'hadoop-0.20-datanode',
    hasstatus  => true,
    hasrestart => true,
    require    => Package['hadoop-0.20-datanode'],
  }
}
