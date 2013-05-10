#Create ganglia installation and configuration.

class cdh3::ganglia {
  package { 'ganglia-gmond':
    ensure => installed,
  }
}
