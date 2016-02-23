require 'spec_helper'

describe "task 1:" do
  it 'create the directory structure for your accounts module' do
    file("#{MODULE_PATH}accounts").should be_directory
    file("#{MODULE_PATH}accounts/manifests").should be_directory
  end
end

describe "task 2:" do
  it 'define the accounts class' do
    file("#{MODULE_PATH}accounts/manifests/init.pp").content.should match /class accounts \(\s*\$user_name\s*=\s*'admin'\s*\)\s*\{\s+if\s+\$::osfamily\s==\s\'\w+\'\s+\{/
    file("#{MODULE_PATH}accounts/manifests/init.pp").content.should match /user\s+\{\s*\$user_name:\s+ensure\s+=>\s+\'?present\'?,(.|\s)+(\$groups,)\s+\}/
  end
end

describe "task 3:" do
  it 'declare the accounts class in a test manifest' do 
    file("#{MODULE_PATH}accounts/examples").should be_directory
    file("#{MODULE_PATH}accounts/examples/init.pp").content.should match /class\s+\{\s*\'?accounts\'?/
  end
end

describe "task 4:" do
  it 'run a noop with operatingsystem set to debian' do 
    file('/root/.bash_history').content.should match /FACTER_osfamily=Debian\spuppet\sapply\s--noop\s(\w*\/)*init.pp/i
  end
end

describe "task 5:" do
  it 'run a noop with operatingsystem set to an unsupported value' do 
    file('/root/.bash_history').content.should match /FACTER_osfamily=((?!(RedHat|Debian)).)*\spuppet\sapply\s--noop\s(\w*\/)*init.pp/i
  end
end

describe 'task 6:' do
  it 'apply your manifest to ensure the user p4h is present and in the sudo group' do
    user('p4h').should belong_to_group 'sudo'
  end
end
