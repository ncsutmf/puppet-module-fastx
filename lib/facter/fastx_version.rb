Facter.add('fastx_version') do
  setcode do
    cmd = "/bin/true" # Default to nothing

    case Facter.value(:operatingsystem)
    when 'Ubuntu', 'Debian'
      cmd = "/usr/bin/dpkg-query --showformat='${Version}' --show starnetfastx2 || /usr/bin/dpkg-query --showformat='%{Version}' --show fastx-server"
    when 'CentOS', 'RedHat', 'Fedora'
      cmd = '/bin/rpm -q StarNetFastX2 > /dev/null && /bin/rpm -q --qf "%{VERSION}" StarNetFastX2 || /bin/rpm -q --qf "%{VERSION}" fastx-server'
    end

    Facter::Core::Execution.execute(cmd)
  end
end
