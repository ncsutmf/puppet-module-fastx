Facter.add('fastx_version') do
  setcode do
    cmd = "/bin/false" # Default to nothing

    case Facter.value(:operatingsystem)
    when 'Ubuntu', 'Debian'
      cmd = "/usr/bin/dpkg-query --showformat='${Version}' --show starnetfastx2"
    when 'CentOS', 'RedHat', 'Fedora'
      cmd = '/bin/rpm -q --qf "%{VERSION}" StarNetFastX2'
    end

    Facter::Core::Execution.execute(cmd)
  end
end
