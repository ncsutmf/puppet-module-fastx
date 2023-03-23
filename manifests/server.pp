# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include fastx::server
class fastx::server (
  Optional[String] $license_server = undef,
  Optional[Boolean] $allow_web_sessions = false,
  Optional[Boolean] $manage_repo = false,
  Optional[String] $apt_baseurl = undef,
  Optional[String] $apt_gpgid = undef,
  Optional[String] $apt_gpgurl = undef,
  Optional[String] $apt_repo = 'main',
  Optional[String] $apt_release = 'stable',
  Optional[String] $yum_baseurl = undef,
  Optional[String] $yum_gpgurl = undef,
) inherits fastx::params {

  include ::fastx::server::install
  include ::fastx::server::config
  include ::fastx::server::service

  anchor { 'fastx::server::start': }
  anchor { 'fastx::server::end': }

  Anchor['fastx::server::start']
  -> Class['fastx::server::install']
  -> Class['fastx::server::config']
  ~> Class['fastx::server::service']
  -> Anchor['fastx::server::end']
}
