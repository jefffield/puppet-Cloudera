class cdh3::hbase::masterserver inherits cdh3::hbase {
  package { 'hadoop-hbase-master':
    ensure  => installed,
    name    => 'hadoop-hbase-master',
    require => Package['jdk'],
  }
  service { 'hadoop-hbase-master':
    ensure     => running,
    name       => 'hadoop-hbase-master',
    hasstatus  => true,
    hasrestart => true,
    require    => Package ['hadoop-hbase-master'],
  }
  #file { 'regionservers':
  #  path    => "${hbase_conf_path}/regionservers",
  #  owner   => root,
  #  group   => root,
  #  mode    => 664,
  #  source  => 'puppet:///hbase/regionservers',
  #  require => Package['hadoop-hbase-master'],
  #}
  }
