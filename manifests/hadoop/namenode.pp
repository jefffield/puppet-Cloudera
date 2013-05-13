#hadoop namenode class
class cdh3::hadoop::namenode inherits cdh3::hadoop {
  file {'rack.script':
    path   => "${::conf_path}/rack.script",
    owner  => root,
    group  => root,
    mode   => '0755',
    source => 'puppet:///hdfs/rack.script',
  }


  package {'hadoop-0.20-namenode':
    ensure  => installed,
    name    => 'hadoop-0.20-namenode',
    require => Package['jdk'],
  }
  service { 'hadoop-namenode':
    name       => 'hadoop-0.20-namenode',
    hasstatus  => true,
    hasrestart => true,
    require    => Package['hadoop-0.20-namenode'],
  }

}
