class apticron (
  $email_apticron    = $apticron::params::apticron,
  $email_listchanges = $apticron::params::listchanges
) inherits apticron::params {

  validate_string(hiera('apticron'))
  validate_string(hiera('listchanges'))

  apticron::listchanges { '/etc/apt/listchanges.conf':
    email => $email_listchanges,
  }

  apticron::config { '/etc/apticron/apticron.conf':
    email => $email_apticron,
  }

  file { '/etc/cron.d/apticron':
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('apticron/common/etc/cron.d/apticron.erb'),
    require => [
      File['apticron.conf'],
      Package['apticron']
    ],
  }

  file { '/etc/cron.daily/apticron':
    ensure => absent,
  }

  package { [
    'apticron',
    'apt-listchanges',
    'apt-show-versions' ]:
    ensure => present,
  }
}