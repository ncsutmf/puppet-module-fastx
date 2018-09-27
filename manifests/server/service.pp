# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
class fastx::server::service {
  service { $::fastx::server::web_service_name:
    ensure => $::fastx::server::allow_web_sessions,
    enable => $::fastx::server::allow_web_sessions,
  }
}
