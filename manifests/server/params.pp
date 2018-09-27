# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include fastx::params
class fastx::server::params {
  $web_service_name = 'fastx'
  $manage_user = true
  $manage_group = true
  $fastx_user = 'fastx'
  $fastx_group = 'fastx'

  $install_dir = '/usr/lib/fastx2'
  $config_dir = "${install_dir}/var/config"
  $license_dir = "${install_dir}/var/license"

  case $facts['os']['family'] {
    'Debian': {
      $client_packages = ['fastx-']
      $server_packages = ['alien', 'starnetfastx2']
    }
    'RedHat': {
      $server_packages = []
    }
    default: {
      fail("${facts['os']['name']} not supported")
    }
  }
}
