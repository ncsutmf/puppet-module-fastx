# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
class fastx::server::install {
  if $::fastx::server::manage_repo {
    if $facts['os']['family'] == 'Debian' {
      apt::source { 'fastx':
        ensure   => 'present',
        location => $fastx::server::apt_baseurl,
        repos    => $fastx::server::apt_repo,
        key      => {
          id     => $fastx::server::apt_gpgid,
          source => $fastx::server::apt_gpgurl,
        },
        felease  => $fastx::server::apt_release,
        before   => Package[$fastx::server::server_packages],
      }
    } elsif $facts['os']['family'] == 'RedHat' {
      yumrepo { 'fastx':
        ensure   => 'present',
        baseurl  => $fastx::server::yum_baseurl,
        gpgkey   => $fastx::server::yum_gpgurl,
        descr    => 'FastX Packages - $releasever',
        enabled  => '1',
        gpgcheck => '1',
      }
    }
  }

  package { $fastx::server::server_packages:
    ensure => 'latest'
  }

  file { "${fastx::server::install_dir}/fastx.version":
    ensure  => 'present',
    content => $::fastx_version,
    require => Package[$fastx::server::server_packages],
    notify  => Exec['fastx installer']
  }

  exec { 'fastx installer':
    refreshonly => true,
    command     => "${fastx::server::install_dir}/install.sh -q",
  }
}
