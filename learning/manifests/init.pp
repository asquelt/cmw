class learning ($git_branch='release') {

  class { '::learning::quest':
    git_branch => $git_branch
  }
  contain learning::quest

  File {
    owner => 'root',
    group => 'root',
    mode  => '644',
  }
  Exec {
    path => [ '/bin', '/usr/bin', '/usr/local/bin' ],
    cwd  => '/',
  }

  # Print this info when we log in, too.
  file {'/etc/motd':
    ensure => absent,
  }

  package { 'pv': ensure => installed }

  file {'/etc/profile.d/welcome-p4h.sh':
    ensure  => file,
    owner   => 'root',
    mode    => '0755',
    content => '[[ $- != *i* ]] && return ; [ $UID -ne 0 ] && cat /etc/README | pv -qL 60',
    require => [ File['/etc/README'], Package['pv'] ],
  }

  file { [ '/root/README', '/etc/README' ]:
    ensure => file,
    mode   => '0644',
    source => 'puppet:///modules/learning/README',
  }

  file { '/root/bin':
    ensure => directory,
  }

  file { '/var/lib/hiera':
    ensure => directory,
  }

  ## Install learning VM specific things
  include learning::install
  include learning::ssh
  include learning::set_defaults

}
