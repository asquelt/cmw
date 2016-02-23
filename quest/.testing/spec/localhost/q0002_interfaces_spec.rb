require 'spec_helper'

describe "task 1:" do
  it 'list all system facts (2 methods)' do 
    file('/root/.bash_history').content.should match /puppet\s+facts/
    file('/root/.bash_history').content.should match /facter/
  end
end

describe "task 2:" do
  it 'list just "ipaddress" fact' do 
    file('/root/.bash_history').content.should match /facter.+ipaddress/
  end
end

describe "task 3:" do
  it 'debug getting facts' do 
    file('/root/.bash_history').content.should match /puppet\s+facts\s+--debug/
  end
end

describe "task 4:" do
  it 'list hiera "puppet_enterprise::profile::puppetdb::listen_address" key (2 methods)' do 
    file('/root/.bash_history').content.should match /puppet\s+lookup\s+puppet_enterprise::profile::puppetdb::listen_address/
    file('/root/.bash_history').content.should match /hiera\s+puppet_enterprise::profile::puppetdb::listen_address/
  end
end

describe "task 5:" do
  it 'debug hiera "puppet_enterprise::profile::puppetdb::listen_address" lookup' do 
    file('/root/.bash_history').content.should match /puppet\s+lookup\s+--debug/
  end
end

describe "task 6:" do
  it 'inline edit root user and change his GECOS field' do 
    file('/root/.bash_history').content.should match /puppet\s+resource\s+user\s+root\s+(-e|--edit)/
    file('/etc/passwd').content.should_not match /^root:x:0:0:root:/
  end
end

describe "task 7:" do
  it 'generate certificate for "foo.acme.com"' do 
    file('/root/.bash_history').content.should match /puppet\s+cert\s+generate/
    file('/etc/puppetlabs/puppet/ssl/certs/foo.acme.com.pem').should be_file
  end
end

describe "task 8:" do
  it 'list all certificates known to your CA' do 
    file('/root/.bash_history').content.should match /puppet\s+cert\s+list\s+--all/
  end
end

describe "task 9:" do
  it 'try to find easter egg in "puppet help" ;)' do 
    file('/root/.bash_history').content.should match /puppet\s+(help\s*){5}/
  end
end

