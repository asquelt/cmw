require 'spec_helper'


describe "task 1:" do
  it 'create the sshd module directory with manifests, examples, and files subdirectories' do
    file("#{MODULE_PATH}sshd").should be_directory
    file("#{MODULE_PATH}sshd/manifests").should be_directory
    file("#{MODULE_PATH}sshd/examples").should be_directory
    file("#{MODULE_PATH}sshd/files").should be_directory
  end
end

describe "task 2:" do
  it 'define the sshd class' do
    file("#{MODULE_PATH}sshd/manifests/init.pp").content.should match /class sshd \{/
    file("#{MODULE_PATH}sshd/manifests/init.pp").content.should match /package { 'openssh-server':/
    file("#{MODULE_PATH}sshd/manifests/init.pp").content.should match /service { 'ssh':/
  end
end

describe "task 3:" do
  it "create a test manifest, and apply it with `--noop` and `--graph` flags" do
    file("#{MODULE_PATH}sshd/examples/init.pp").should contain "include sshd"
    file("/opt/puppetlabs/puppet/cache/state/graphs/relationships.dot").should contain "sshd"
  end
end

describe "task 4:" do
  it "use the `dot` tool to generate an image of your resource relationships graph" do
    file('/root/.bash_history').content.should match /dot\s+/                                                                                                      
  end
end

describe "task 5:" do
  it "copy the sshd_config file to the module's files direcotry" do
    file("#{MODULE_PATH}sshd/files/sshd_config").should be_file
  end
end

describe "task 6:" do
  it "disable GSSAPIAuthentication in the module's sshd_config file" do
    file("#{MODULE_PATH}sshd/files/sshd_config").content.should match /^GSSAPIAuthentication no/
    file("#{MODULE_PATH}sshd/files/sshd_config").content.should_not match /^GSSAPIAuthentication yes/
  end
end

describe "task 7:" do
  it 'add a `file` resource to manage the `sshd` configuration file' do
    file("#{MODULE_PATH}sshd/manifests/init.pp").content.should match /file\s+\{\s+'\/etc\/ssh\/sshd_config':/
    file("#{MODULE_PATH}sshd/manifests/init.pp").content.should match /(source\s+=>\s+'puppet:\/\/\/modules\/sshd\/sshd_config',|content\s+=>\s+template\('sshd\/sshd_config'\))/
    file("#{MODULE_PATH}sshd/manifests/init.pp").content.should match /require\s+=>\s+Package\['openssh-server'\]/
  end
end

describe "task 8:" do
  it "apply your test manifest with the `--noop` and `--graph` flags" do
    file("/opt/puppetlabs/puppet/cache/state/graphs/relationships.dot").should contain "sshd_config"
  end
end


describe "task 9:" do
  it 'add a `subscribe` metaparameter to your `sshd` resource' do
    file("#{MODULE_PATH}sshd/manifests/init.pp").content.should match /subscribe\s+=>\s+File\['\/etc\/ssh\/sshd_config'\]/
  end
end
