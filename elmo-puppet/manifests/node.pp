node default {
  include elmo-base

  file { "/etc/sysconfig/puppet" :
    content => 'PUPPET_EXTRA_OPTS="--pluginsync"',
  }


}
