require 'spec_helper'

describe "task 1:" do
  it 'install r10k module' do
    file("#{MODULE_PATH}r10k").should be_directory
  end
end

describe "task 2:" do
  it 'create "puppet-control" repository in /var/lib/git' do
    command("cd /var/lib/git/puppet-control && git log").exit_status.should be_zero
  end
end

describe "task 3:" do
  it 'install and configure r10k to use given control repository' do
    file('/etc/puppetlabs/r10k/r10k.yaml').should be_file
    file('/etc/puppetlabs/r10k/r10k.yaml').content.should match /remote: file:\/\/\/var\/lib\/git\/puppet-control/
  end
end

describe "task 4:" do
  it 'commit Puppetfile to "puppet-control" repository - add some forge and some github modules to p4h branch' do
    command("cd /var/lib/git/puppet-control && git log p4h").exit_status.should be_zero
  end
end

describe "task 5:" do
  it 'create p4h puppet environment with r10k' do
    file("/etc/puppetlabs/code/environments/p4h").should be_directory
  end
end

describe "task 6:" do
  it 'create a "legacy" branch with some other versions (refs or semvers) of the same modules' do
    command("cd /var/lib/git/puppet-control && git log legacy").exit_status.should be_zero
  end
end

describe "task 6:" do
  it 'create legacy puppet environment with r10k' do
    file("/etc/puppetlabs/code/environments/legacy").should be_directory
  end
end

describe "task 7:" do
  it 'make a hook so r10k updates puppet ater every commit to "puppet-control" repository' do
    file('/var/lib/git/puppet-control/hooks/update').should be_file
  end
end
