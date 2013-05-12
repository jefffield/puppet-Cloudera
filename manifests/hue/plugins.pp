class cdh3::hue::plugins {
  package { 'hue-plugins':
    ensure => installed,
    name   => 'hue-plugins',
  }
}
