# == Class: apticron::params
#
class apticron::params {
  $package_name = $::osfamily ? {
    default => 'apticron',
  }

  $package_list = $::osfamily ? {
    default => ['apt-listchanges'],
  }

  $config_dir_path = $::osfamily ? {
    default => '/etc/apticron',
  }

  $config_file_path = $::osfamily ? {
    default => '/etc/apticron/apticron.conf',
  }

  $config_file_owner = $::osfamily ? {
    default => 'root',
  }

  $config_file_group = $::osfamily ? {
    default => 'root',
  }

  $config_file_mode = $::osfamily ? {
    default => '0644',
  }

  $config_file_require = $::osfamily ? {
    default => 'Package[apticron]',
  }

  case $::osfamily {
    'Debian': {
    }
    default: {
      fail("${::operatingsystem} not supported.")
    }
  }
}
