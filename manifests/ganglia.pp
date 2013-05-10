#Create ganglia installation and configuration.
class cdh3::ganglia {
}

class cdh3::ganglia::common {
  package { 'ganglia-gmond':
    ensure => installed,
  }

}

define cdh3::ganglia::config (
  $rackloc = 'Unspecified',
  $send_hosts = [ '1.1.1.1' , '1.1.1.2' ]
) {
  file {
    '/etc/ganglia/gmond.conf':
      ensure  => present,
      content => template('ganglia/gmond.conf.erb'),
      owner   => 'root',
      group   => 'root',
      mode    => '0644';
  }
  Package[ 'ganglia-gmond'] -> File[ '/etc/ganglia/gmond.conf']
}

class cdh3::ganglia::client inherits cdh3::ganglia::common {
  service { 'gmond':
    ensure     => running,
    subscribe  => File['/etc/ganglia/gmond.conf'],
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    #require   => File['/etc/init.d/gmond'];
    }

}

class cdh3::ganglia::server inherits cdh3::ganglia::common {
  file {
    '/etc/init.d/gmetad':
      ensure => present,
      source => 'puppet:///modules/ganglia/gmetad',
      owner  => 'root',
      group  => 'root',
      mode   => '0755';
    '/etc/gmetad.conf':
      ensure => present,
      source => 'puppet:///modules/ganglia/gmetad.conf',
      owner  => 'root',
      group  => 'root',
      mode   => '0644';
  }
  service {
    'gmetad':
      pattern => '/usr/local/sbin/gmetad',
      ensure  => running,
      require => File['/etc/init.d/gmetad'];
  }
}
