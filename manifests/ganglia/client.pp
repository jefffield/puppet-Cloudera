class cdh3::ganglia::client inherits cdh3::ganglia {
  service { 'gmond':
    ensure     => running,
    subscribe  => File['/etc/ganglia/gmond.conf'],
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    #require   => File['/etc/init.d/gmond'];
    }
}
