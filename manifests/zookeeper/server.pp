class cdh3::zookeeper::server inherits cdh3::zookeeper {
  package { 'hadoop-zookeeper-server':
    ensure => installed,
  }

  service { 'hadoop-zookeeper':
    ensure     => running,
    name       => 'hadoop-zookeeper',
    hasstatus  => true,
    hasrestart => true,
    subscribe  => File['zoo.cfg'],

  }
  file { 'zookeeper_server_id':
    path    => '/var/zookeeper/myid',
    content => template('zookeeper/myid.erb'),
  }
}
