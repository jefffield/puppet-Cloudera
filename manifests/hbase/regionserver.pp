class cdh3::hbase::regionserver inherits cdh3::hbase {
  package {'hbase-regionserver':
    ensure => installed,
    name   => 'hadoop-hbase-regionserver',
  }
  service {'hbase-regionserver':
    ensure     => running,
    name       => 'hadoop-hbase-regionserver',
    hasstatus  => true,  # status does not work in B3
    hasrestart => true,
    require    => Package ['hbase-regionserver'],
  }
}
