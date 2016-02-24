class learning::quest ($git_branch='release') {
  
  $doc_root = '/var/www/html/questguide/'
  $proxy_port = '80'
  $graph_port = '90'

  include nginx

  nginx::resource::vhost { "_":
    ensure         => present,
    listen_port    => "${proxy_port}",
    listen_options => 'default',
    www_root       => $doc_root,
    require        => File['doc_root'],
  }

  nginx::resource::location { '~ ^/~(.+?)(/.*)?$':
    ensure         => present,
    vhost          => '_',
    location_alias => '/home/$1/public_html$2',
    autoindex      => 'on',
  }

  # Create docroot for lvmguide files, so the website files
  # can be put in place

  file { '/var/www/html':
    ensure  => directory,
  }

  file { 'doc_root':
    path    => $doc_root,
    ensure  => directory,
    owner   => 'nginx',
    group   => 'nginx',
    mode    => '755',
    require => Package['nginx'],
  }

  package { 'tmux':
    ensure  => 'present',
  }

  file { '/etc/tmux.conf':
    ensure  => file,
    mode    => '0644',
    source  => 'puppet:///modules/learning/tmux.conf',
    require => Package['tmux'],
  }

  package { 'nodejs':
    ensure  => present,
  }

  package { 'python-pip':
    ensure => present,
  }

  file { ['/opt/quest', '/opt/quest/bin', '/opt/quest/gems']:
    ensure => directory,
  }

  $rake_gems = ['jekyll','redcarpet','pygments.rb','rspec','trollop','rest-client']
  $rake_gems.each |$gem| {
    exec { "install ${gem}":
      command => "/opt/puppetlabs/puppet/bin/gem install ${gem} -i /opt/quest/gems -n /opt/quest/bin --source https://rubygems.org/",
      creates => "/opt/puppetlabs/puppet/bin/${gem}",
      require => [File['/opt/quest/bin'], File['/opt/quest/gems'], Package['nodejs']],
      before  => Exec['rake update'], 
    }
  }

  exec { "install serverspec":
    command => "/opt/puppetlabs/puppet/bin/gem install serverspec -v 1.16.0 -i /opt/quest/gems -n /opt/quest/bin --source https://rubygems.org/",
    creates => "/opt/puppetlabs/puppet/bin/serverspec",
    require => [File['/opt/quest/bin'], File['/opt/quest/gems'], Package['nodejs']],
    before  => Exec['rake update'], 
  }

  file { '/root/.gitconfig':
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    content => "[user]\n  email = vagrant@hashicorp.com\n  name = Vagrant User\n\n",
  }

  vcsrepo { '/usr/src/courseware-lvm':
    ensure   => present,
    provider => git,
    source   => 'git://github.com/puppetlabs/courseware-lvm.git',
    require  => File['/root/.gitconfig'],
  }

  exec { 'rake update':
    environment => ["GH_BRANCH=${git_branch}"],
    command     => "/opt/puppetlabs/puppet/bin/rake update",
    cwd         => '/usr/src/courseware-lvm/',
    require     => Vcsrepo['/usr/src/courseware-lvm'],
    logoutput   => true,
  }

  service { 'puppet':
    ensure  => stopped,
    enable  => false,
  }

}
