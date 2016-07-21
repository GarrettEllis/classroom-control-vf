File { backup => false }

# Randomize enforcement order to help understand relationships
ini_setting { 'random ordering':
  ensure  => present,
  path    => "${settings::confdir}/puppet.conf",
  section => 'agent',
  setting => 'ordering',
  value   => 'title-hash',
}

node default {

  #notify { "Well here we are again; my name is ${::hostname}": }
  if $facts['is_virtual'] == true {
    $up_case_vm = upcase($facts['virtual'])
    notify { "This is a ${up_case_vm} virtual machine": }
  }

  include users
  include skeleton
  include memcached
  include nginx
  exec { "/usr/local/bin/cowsay 'Welcome to ${::fqdn}!' > /etc/motd":
      user => 'root',
      creates => '/etc/motd',
  }
  host { 'testing.puppetlabs.vm':
      ensure => present,
      ip     => '127.0.0.1',
  }
}
