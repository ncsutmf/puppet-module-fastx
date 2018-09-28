# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include fastx::server
class fastx::client (
  Optional[String] $license_server = undef,
  Optional[Boolean] $allow_web_sessions = false,
  Optional[Boolean] $manage_repo = false,
  Optional[String] $apt_baseurl = undef,
  Optional[String] $apt_gpgid = undef,
  Optional[String] $apt_gpgurl = undef,
  Optional[String] $apt_repo = 'main',
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
    }
  }

  package { $fastx::client::client_packages:
    ensure => 'latest'
  }
}
