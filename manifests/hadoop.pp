#== Class: cdh3::hadoop
#
#Basic class which deploy hdfs client libraries and hdfs related configuration
#
#Usage:
#
#  include cdh3::hadoop
#

class cdh3::hadoop {

  #installing Cloudera hdfs common package
  package { 'hadoop-common':
    ensure  => installed,
    name    => "hadoop-${::hadoop_version}",
    require => Package['jdk'],
  }
  #installing Cloudera hdfs native libraries for native compression support
  package { 'hadoop-native':
    ensure  => installed,
    name    => "hadoop-${::hadoop_version}-native",
    require => Package['jdk'],
  }
  #installing lzo native libraries to support
  package { 'lzo-libs':
    ensure => installed,
    name   => 'lzo',
  }

  #creating hdfs config directory and pointing alternative to it
  file { 'conf':
    ensure => directory,
    path   => $::conf_path,
    owner  => root,
    group  => root,
    mode   => '0755',
  }
  exec {"alternatives --install /etc/hadoop-${::hadoop_version}/conf hadoop-${::hadoop_version}-conf /etc/hadoop-${::hadoop_version}/${::conf_name} 60; alternatives --set /etc/hadoop-${::hadoop_version}/conf hadoop-${::hadoop_version}-conf":
    refreshonly => true,
    subscribe   => File['conf'],
  }

  #Hadoop Environment File
  file { 'hadoop-env.sh':
    path    => "${::conf_path}/hadoop-env.sh",
    owner   => root,
    group   => root,
    mode    => '0755',
    require => Package['hadoop-common'],
    source  => 'puppet:///hdfs/hadoop-env.sh',
  }

  #hadoop scheduler file
  file { 'capacity-scheduler.xml':
    path    => "${::conf_path}/capacity-scheduler.xml",
    owner   => root,
    group   => root,
    mode    => '0644',
    require => Package['hadoop-common'],
    source  => 'puppet:///hdfs/capacity-scheduler.xml',
  }

  file { 'configuration.xsl':
    path    => "${::conf_path}/configuration.xsl",
    owner   => root,
    group   => root,
    mode    => '0644',
    require => Package['hadoop-common'],
    source  => 'puppet:///hdfs/configuration.xsl',
  }

  #core-site configuration file
  file { 'core-site.xml':
    path    => "${::conf_path}/core-site.xml",
    owner   => root,
    group   => root,
    mode    => '0644',
    require => Package['hadoop-common'],
    content => template('hdfs/core-site.xml.erb')
  }

  #fair-scheduler config file
  file { 'fair-scheduler.xml':
    path    => "${::conf_path}/fair-scheduler.xml",
    owner   => root,
    group   => root,
    mode    => '0644',
    require => Package['hadoop-common'],
    source  => 'puppet:///hdfs/fair-scheduler.xml',
  }

  #hadoop metrics file
  file { 'hadoop-metrics.properties':
    path    => "${::conf_path}/hadoop-metrics.properties",
    owner   => root,
    group   => root,
    mode    => '0644',
    require => Package['hadoop-common'],
    content => template('hdfs/hadoop-metrics.properties.erb')
  }

  #hadoop hdfs-site config file
  file { 'hdfs-site.xml':
    path    => "${::conf_path}/hdfs-site.xml",
    owner   => root,
    group   => root,
    mode    => '0644',
    require => Package['hadoop-common'],
    content => template('hdfs/hdfs-site.xml.erb'),
  }

  #mapreduce configuration file
  file { 'mapred-site.xml':
    path    => "${::conf_path}/mapred-site.xml",
    owner   => root,
    group   => root,
    mode    => '0644',
    require => Package['hadoop-common'],
    content => template('hdfs/mapred-site.xml.erb')
  }


  file { 'hadoop-policy.xml':
    path    => "${::conf_path}/hadoop-policy.xml",
    owner   => root,
    group   => root,
    mode    => '0644',
    require => Package['hadoop-common'],
    source  => 'puppet:///hdfs/hadoop-policy.xml',
  }

  file { 'log4j.properties':
    path    => "${::conf_path}/log4j.properties",
    owner   => root,
    group   => root,
    mode    => '0644',
    require => Package['hadoop-common'],
    source  => 'puppet:///hdfs/log4j.properties',
  }

  file { 'mapred-queue-acls.xml':
    path    => "${::conf_path}/mapred-queue-acls.xml",
    owner   => root,
    group   => root,
    mode    => '0644',
    require => Package['hadoop-common'],
    source  => 'puppet:///hdfs/mapred-queue-acls.xml',
  }
  file { 'taskcontroller.cfg':
    path    => "${::conf_path}/taskcontroller.cfg",
    owner   => root,
    group   => root,
    mode    => '0644',
    require => Package['hadoop-common'],
    source  => 'puppet:///hdfs/taskcontroller.cfg',
  }
  #adding lzo library support for hdfs
  #    file { 'hadoop-lzo-jar':
  #      path    => "${lib_path}/lib/hadoop-lzo.jar",
  #      owner   => root,
  #      group   => root,
  #      mode    => '0644',
  #      source  => "puppet:///hdfs/hadoop-lzo/hadoop-lzo-${lzo_version}.jar",
  #      require => Package['hadoop-common'],
  #    }
  #    file { 'libgplcompression.a':
  #      path    => "${lib_path}/lib/native/Linux-amd64-64/libgplcompression.a",
  #      owner   => root,
  #      group   => root,
  #      mode    => '0755',
  #      source  => "puppet:///hdfs/hadoop-lzo/native-${lzo_version}/Linux-amd64-64/libgplcompression.a",
  #      require => Package['hadoop-common'],
  #    }
  #
  #    file {'libgplcompression.la':
  #      path    => "${lib_path}/lib/native/Linux-amd64-64/libgplcompression.la",
  #      owner   => root,
  #      group   => root,
  #      mode    => '0755',
  #      source  => "puppet:///hdfs/hadoop-lzo/native-${lzo_version}/Linux-amd64-64/libgplcompression.la",
  #      require => Package['hadoop-common'],
  #    }
  #
  #    file { 'libgplcompression.so.0.0.0':
  #      path    => "${lib_path}/lib/native/Linux-amd64-64/libgplcompression.so.0.0.0",
  #      owner   => root,
  #      group   => root,
  #      mode    => '0755',
  #      source  => "puppet:///hdfs/hadoop-lzo/native-${lzo_version}/Linux-amd64-64/libgplcompression.so.0.0.0",
  #      require => Package['hadoop-common'],
  #    }
  #
  #    file {'libgplcompression.so.0':
  #      path    => "${lib_path}/lib/native/Linux-amd64-64/libgplcompression.so.0",
  #      ensure  => symlink,
  #      target  => "${lib_path}/lib/native/Linux-amd64-64/libgplcompression.so.0.0.0",
  #      require => Package['hadoop-common'],
  #    }
  #
  #    file {'libgplcompression.so':
  #      path    => "${lib_path}/lib/native/Linux-amd64-64/libgplcompression.so",
  #      ensure  => symlink,
  #      target  => "${lib_path}/lib/native/Linux-amd64-64/libgplcompression.so.0.0.0",
  #      require => Package['hadoop-common'],
  #    }
  #  }
  #creating data directories for data nodes. $name opens a list of directory names
  }

  define cdh3::hadoop::datadirs() {
    file { $name:
      ensure => directory,
      path   => $name,
      owner  => hdfs,
      group  => hadoop,
      mode   => '0700',
    }
    exec {"mkdir -p ${name}":
      refreshonly => true,
      subscribe   => File[$name],
    }
  }

  #creating mapred temp directories on data nodes. $name opens a list of directory names
  define cdh3::hadoop::mapreddirs() {
    file {"${name}":
      ensure => directory,
      path   => "${name}",
      owner  => mapred,
      group  => hadoop,
      mode   => '0755',
    }
    exec {"mkdir -p ${name}":
      refreshonly => true,
      subscribe   => File["${name}"],
    }
  }
