# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include fastx::params
class fastx::params {
  $web_service_name = 'fastx3'
  $manage_user = true
  $manage_group = true
  $fastx_user = 'fastx'
  $fastx_group = 'fastx'

  $install_dir = '/usr/lib/fastx/latest'
  $config_dir = '/etc/fastx'
  $license_dir = "${install_dir}/var/license"

  $client_packages = ['fastx-client']
  $server_packages = ['fastx-server']

  case $facts['os']['family'] {
    'Debian': {
      $user_shell = '/usr/sbin/nologin'
    }
    'RedHat': {
      $user_shell = '/sbin/nologin'
    }
    default: {
      fail("${facts['os']['name']} not supported")
    }
  }
}
