define apticron::listchanges($email) {
  file { $name:
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('apticron/common/etc/apt/listchanges.conf.erb'),
    require => Package['apt-listchanges'],
  }
}