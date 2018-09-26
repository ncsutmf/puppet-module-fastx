Facter.add('fastx_version') do
  setcode do
    case Facter.value(:operatingsystem)
      when 'Ubuntu', 'Debian'
        cmd = %Q{/usr/bin/dpkg-query --showformat='${Version}' --show starnetfastx2}
      when 'CentOS', 'RedHat', 'Fedora'
        cmd = ''
    end

    Facter::Core::Execution.execute(cmd)
  end
end
