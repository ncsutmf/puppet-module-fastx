# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
class fastx::server::config {
  file { $fastx::server::license_dir:
    ensure  => 'directory',
    recurse => true,
    purge   => true,
    owner   => $fastx::server::fastx_user,
    group   => $fastx::server::fastx_group,
  }

  file { "${fastx::server::license_dir}/${fastx::server::license_server}.lic":
    ensure  => 'file',
    content => "HOST ${fastx::server::license_server} 00000000 5053",
    mode    => '0644',
    owner   => $fastx::server::fastx_user,
    group   => $fastx::server::fastx_group,
  }

  if $fastx::server::manage_user {
    user { 'fastx':
      ensure           => 'present',
      home             => '/usr/lib/fastx2',
      password         => '!',
      password_max_age => '-1',
      password_min_age => '-1',
      shell            => $fastx::server::user_shell,
    }
  }

  if $fastx::server::manage_group {
    group { 'fastx':
      ensure => 'present',
    }
  }
}
