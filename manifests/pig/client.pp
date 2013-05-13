class cdh3::pig::client{
  package { 'hadoop-pig':
    ensure  => installed,
    require => Package['jdk'],
  }
}
