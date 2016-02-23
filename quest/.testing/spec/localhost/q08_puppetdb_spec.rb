require 'spec_helper'

describe "task 1:" do
  it 'install puppetdb module' do
    file("#{MODULE_PATH}puppetdb").should be_directory
  end
end

describe "task 2:" do
  it 'install puppetdb server' do
    file('/etc/puppetlabs/puppetdb/conf.d/jetty.ini').should be_file
  end
end

describe "task 3:" do
  it 'export "/tmp/1.txt" file' do
    command("puppet node exports").exit_status.should_not be_zero
  end
end

describe "task 4:" do
  it 'install puppetexplorer module' do
    file("#{MODULE_PATH}puppetexplorer").should be_directory
  end
end

describe "task 5:" do
  it 'install puppetexplorer app (apache vhost)' do
    file('/usr/share/puppetexplorer/index.html').should be_file
  end
end
