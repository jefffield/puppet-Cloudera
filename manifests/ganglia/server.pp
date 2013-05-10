class cdh3::ganglia::server inherits cdh3::ganglia {
  file { '/etc/init.d/gmetad':
      ensure => present,
      source => 'puppet:///modules/ganglia/gmetad',
      owner  => 'root',
      group  => 'root',
      mode   => '0755';
  }
  file { '/etc/gmetad.conf':
      ensure => present,
      source => 'puppet:///modules/ganglia/gmetad.conf',
      owner  => 'root',
      group  => 'root',
      mode   => '0644';
  }
  service {
    'gmetad':
      ensure  => running,
      pattern => '/usr/local/sbin/gmetad',
      require => File['/etc/init.d/gmetad'];
  }
}
