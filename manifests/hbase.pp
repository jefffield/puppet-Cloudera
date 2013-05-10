# /etc/puppet/modules/hbase/manifests/init.pp

class cdh3::hbase {
  include hdfs::common

  package {'hbase-common':
    ensure => installed,
    name   => 'hadoop-hbase',
  }

  file { 'hbase-hadoop-metrics.properties':
    path    => "${::hbase_conf_path}/hadoop-metrics.properties",
    owner   => root,
    group   => root,
    mode    => '0664',
    content => template('hbase/hadoop-metrics.properties.erb'),
    require => Package['hbase-common'],
  }
  #  file { 'hbase-default.xml':
  #    path    => "${hbase_conf_path}/hbase-default.xml",
  #    owner   => root,
  #    group   => root,
  #    mode    => 664,
  #    source  => 'puppet:///hbase/hbase-default.xml',
  #    require => Package['hbase-common'],
  #  }
  file { 'hbase-env.sh':
    path    => "${::hbase_conf_path}/hbase-env.sh",
    owner   => root,
    group   => root,
    mode    => '0755',
    source  => 'puppet:///hbase/hbase-env.sh',
    require => Package['hbase-common'],
  }
  file { 'hbase-site.xml':
    path    => "${::hbase_conf_path}/hbase-site.xml",
    owner   => root,
    group   => root,
    mode    => '0664',
    content => template('hbase/hbase-site.xml.erb'),
    require => Package['hbase-common'],
  }
  file { 'hbase-log4j.properties':
    path    => "${::hbase_conf_path}/log4j.properties",
    owner   => root,
    group   => root,
    mode    => '0664',
    source  => 'puppet:///hbase/log4j.properties',
    require => Package['hbase-common'],
  }

  file { 'tohtml.xsl':
    path    => "${::hbase_conf_path}/tohtml.xsl",
    owner   => root,
    group   => root,
    mode    => '0664',
    source  => 'puppet:///hbase/tohtml.xsl',
    require => Package['hbase-common'],
  }
  file { 'hbase-jar':
    ensure  => symlink,
    path    => "/usr/lib/hadoop/lib/hbase-${::hbase_version}.jar",
    target  => "/usr/lib/hbase/hbase-${::hbase_version}.jar",
    require => Package['hbase-common'],
  }
  file { 'hbase-native':
    ensure  => symlink,
    path    => '/usr/lib/hbase/lib/native',
    target  => '/usr/lib/hadoop/lib/native',
    require => Package['hbase-common'],
  }
  file { 'hbase-lzo-jar':
    ensure  => symlink,
    path    => '/usr/lib/hbase/lib/hadoop-lzo.jar',
    target  => '/usr/lib/hadoop/lib/hadoop-lzo.jar',
    require => Package['hbase-common'],
  }
}

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

class cdh3::hbase::masterserver inherits cdh3::hbase {

  package {'hadoop-hbase-master':
    ensure => installed,
    name   => 'hadoop-hbase-master',
  }
  service {'hadoop-hbase-master':
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
