node 'puppet.local' {
  if versioncmp($::puppetversion,'3.6.1') >= 0 {
    $allow_virtual_packages = hiera('allow_virtual_packages',false)
    Package {
      allow_virtual => $allow_virtual_packages,
    }
  }

  include elmo-base

  package { "puppet-server":
    ensure => "present",
  }

  service { "puppetmaster" :
    ensure     => running,
    hasrestart => true,
    hasstatus  => true,
    enable     => true,
    require    => [ Group["puppet"], Package['puppet-server'] ],
  }

  exec { "remove all ssl certs":
    command => "/bin/rm -rf /var/lib/puppet/ssl/*",
    notify  => Service["puppetmaster"],
  }

  file { "/etc/sysconfig/puppetmaster" :
      content => 'PUPPETD=/usr/bin/puppet
PUPPET_EXTRA_OPTS="master --pluginsync --autosign true"
PIDFILE=/var/run/puppet/master.pid',
      notify  => Service["puppetmaster"],
  }
}
