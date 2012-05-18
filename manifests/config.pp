define apticron::config($email) {
  file { $name:
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    alias   => 'apticron.conf',
    content => template("apticron/${::lsbdistcodename}/etc/apticron/apticron.conf.erb"),
    require => Package['apticron'],
  }
}