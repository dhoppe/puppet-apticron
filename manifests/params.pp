class apticron::params {
  case $::lsbdistcodename {
    'lenny', 'squeeze', 'maverick', 'natty': {
      $apticron    = hiera('apticron')
      $listchanges = hiera('listchanges')
    }
    default: {
      fail("Module ${module_name} does not support ${::lsbdistcodename}")
    }
  }
}