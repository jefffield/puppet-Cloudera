#hadoop jobtracker file
class cdh3::hadoop::jobtracker inherits cdh3::hadoop {
  package { 'hadoop-0.20-jobtracker':
    ensure  => installed,
    name    => 'hadoop-0.20-jobtracker',
  }
  service { 'hadoop-jobtracker':
    name       => 'hadoop-0.20-jobtracker',
    hasstatus  => true,
    hasrestart => true,
    require    => Package['hadoop-0.20-jobtracker'],
  }
}
