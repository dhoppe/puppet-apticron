define apticron::config($email = false) {
  $t_email = $email ? {
    false   => 'root',
    default => $email,
  }

  file { $name:
    owner   => root,
    group   => root,
    mode    => '0644',
    alias   => 'apticron.conf',
    content => template("apticron/${::lsbdistcodename}/etc/apticron/apticron.conf.erb"),
    require => Package['apticron'],
  }
}