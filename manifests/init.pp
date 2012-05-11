class apticron {
  validate_string(hiera('apticron'))
  validate_string(hiera('listchanges'))

  apticron::listchanges { '/etc/apt/listchanges.conf':
    email => hiera('listchanges'),
  }

  apticron::config { '/etc/apticron/apticron.conf':
    email => hiera('apticron'),
  }

  file { '/etc/cron.d/apticron':
    owner   => root,
    group   => root,
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