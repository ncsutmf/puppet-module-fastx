# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include fastx::server
class fastx::client (
  Optional[Boolean] $manage_repo = false,
  Optional[String] $apt_baseurl = undef,
  Optional[String] $apt_gpgid = undef,
  Optional[String] $apt_gpgurl = undef,
  Optional[String] $apt_repo = 'main',
  Optional[String] $yum_baseurl = undef,
  Optional[String] $yum_gpgurl = undef,
) inherits fastx::params {
  if $manage_repo {
    if $facts['os']['family'] == 'Debian' {
      apt::source { 'fastx':
        ensure   => 'present',
        location => $apt_baseurl,
        repos    => $apt_repo,
        key      => {
          id     => $apt_gpgid,
          source => $apt_gpgurl
        },
        before   => Package[$fastx::client::client_packages]
      }
    } elsif $facts['os']['family'] == 'RedHat' {
      yumrepo { 'fastx':
        ensure   => 'present',
        baseurl  => $yum_baseurl,
        gpgkey   => $yum_gpgurl,
        descr    => 'FastX Packages - $releasever',
        enabled  => '1',
        gpgcheck => '1',
      }
    }
  }

  package { $fastx::client::client_packages:
    ensure => 'latest'
  }
}
