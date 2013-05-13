# /etc/puppet/modules/hive/manifests/init.pp

class cdh3::hive::client {

  $mysql_driver_version='5.1.14'

  package { 'hadoop-hive':
    ensure  => installed,
    require => Package['jdk'],
  }
  file {'hive-site.xml':
    mode    => '0755',
    path    => '/etc/hive/conf/hive-site.xml',
    content => template('hive/hive-site.xml.erb'),
    require => Package['hadoop-hive'],
  }

  file {'mysql-driver':
    mode    => '0755',
    path    => "/usr/lib/hive/lib/mysql-connector-java-${mysql_driver_version}-bin.jar",
    source  => "puppet:///hive/mysql-connector-java-${mysql_driver_version}-bin.jar",
    require => Package['hadoop-hive'],
  }

}

