# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
class fastx::server::install {
  if $facts['os']['family'] == 'Debian' {
    apt::source { 'fastx':
      ensure   => $fastx::server::manage_repo ? {
        true  => 'present',
        false => 'absent'
      },
      location => $fastx::server::apt_baseurl,
      repos    => $fastx::server::apt_repo,
      key      => {
        id     => $fastx::server::apt_gpgid,
        source => $fastx::server::apt_gpgurl
      },
      before   => Package[$fastx::server::packages]
    }
  }

  package { $fastx::server::packages:
    ensure => 'latest'
  }

  file { "${fastx::server::install_dir}/fastx.version":
    ensure  => 'present',
    content => $::fastx_version,
    require => Package[$fastx::server::packages],
    notify  => Exec['fastx installer']
  }

  exec { 'fastx installer':
    refreshonly => true,
    command     => "${fastx::server::install_dir}/install.sh -q",
  }
}
