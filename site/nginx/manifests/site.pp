class nginx {
  package { 'nginx':
    ensure => present,
  }
  service { 'nginx':
    ensure => running,
    enable => true,
    require => File['docroot', 'html'],
  }
  
  file { 'docroot':
    ensure => directory,
    path => '/var/www',
    owner => 'root',
    group => 'root',
    mode => '0755',
    before => Package['nginx'],
  }
  
  file { 'html':
    ensure => file,
    path => '/var/www/index.html',
    owner => 'root',
    group => 'root',
    mode => '0644',
    source => 'puppet:///modules/nginx/index.html',
    before => Package['nginx'],
  }
}
