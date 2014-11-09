# == Class: apticron::config
#
class apticron::config {
  if $::apticron::config_dir_source {
    file { 'apticron.dir':
      ensure  => $::apticron::config_dir_ensure,
      path    => $::apticron::config_dir_path,
      force   => $::apticron::config_dir_purge,
      purge   => $::apticron::config_dir_purge,
      recurse => $::apticron::config_dir_recurse,
      source  => $::apticron::config_dir_source,
      require => $::apticron::config_file_require,
    }
  }

  if $::apticron::config_file_path {
    file { 'apticron.conf':
      ensure  => $::apticron::config_file_ensure,
      path    => $::apticron::config_file_path,
      owner   => $::apticron::config_file_owner,
      group   => $::apticron::config_file_group,
      mode    => $::apticron::config_file_mode,
      source  => $::apticron::config_file_source,
      content => $::apticron::config_file_content,
      require => $::apticron::config_file_require,
    }
  }
}
