class elmo-base {
  group { "puppet":
    ensure => "present",
  }

  filebucket { "main": server => 'puppet' }

  File { backup => main }

  $packages = [
    'puppet',
    'ntp',
    'epel-release'
  ]

  package { $packages:
    ensure => "installed"
  }

  service { "firewalld" :
    ensure => stopped,
    enable => false,
  }

  service { "ntpd":
    enable    => true,
    ensure    => running,
    hasstatus => true,
    require   => Package["ntp"],
  }

  host { "puppet":
    ensure => present,
    ip     => '192.168.80.2',
  }

  host { "puppet-client":
    ensure => present,
    ip     => '192.168.80.3',
  }

}
