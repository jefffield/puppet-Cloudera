class cdh3::hbase::thriftserver inherits cdh3::hbase {
  package {'hbase-thriftserver':
    ensure => installed,
    name   => 'hadoop-hbase-thrift',
  }
  service {'hbase-thriftserver':
    ensure     => running,
    name       => 'hadoop-hbase-thrift',
    hasstatus  => true, #status does not work for thrift server
    hasrestart => true,
    require    => Package ['hbase-thriftserver'],
  }
}
