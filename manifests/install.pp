# == Class: apticron::install
#
class apticron::install {
  if $::apticron::package_name {
    package { 'apticron':
      ensure => $::apticron::package_ensure,
      name   => $::apticron::package_name,
    }
  }

  if $::apticron::package_list {
    ensure_resource('package', $::apticron::package_list, { 'ensure' => $::apticron::package_ensure })
  }
}
