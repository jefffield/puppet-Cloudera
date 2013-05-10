# Obviously config info doesn't belong here but 2-3 steps at a time.

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
