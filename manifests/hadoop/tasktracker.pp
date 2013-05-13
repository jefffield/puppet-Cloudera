#hadoop tasktracker class
class cdh3::hadoop::tasktracker inherits cdh3::hadoop {
  package {'hadoop-0.20-tasktracker':
    ensure  => installed,
    name    => 'hadoop-0.20-tasktracker',
    require => Package['jdk'],
  }
  service { 'hadoop-tasktracker':
    ensure     => running,
    name       => 'hadoop-0.20-tasktracker',
    hasstatus  => true,
    hasrestart => true,
    require    => Package['hadoop-0.20-tasktracker'],
    subscribe  => [
      File['mapred-site.xml'],
      File['hdfs-site.xml'],
      File['core-site.xml'],
      File['hadoop-env.sh'],
    ],
  }
}
