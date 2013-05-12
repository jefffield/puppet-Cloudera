class cdh3::hue::server {

  $mysql_driver_version='5.1.14'

  package { 'hue':
    ensure => installed,
    name   => 'hue',
  }
  file { 'hue.ini':
    mode    => '0755',
    path    => '/etc/hue/hue.ini',
    content => template('hue/hue.ini.erb'),
    require => Package['hue'],
  }
  file { 'hue-beeswax.ini':
    mode    => '0755',
    path    => '/etc/hue/hue-beeswax.ini',
    content => template('hue/hue-beeswax.ini.erb'),
    require => Package['hue'],
  }
}
