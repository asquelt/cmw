require 'spec_helper'

describe "task 1:" do
  it 'create the web_user module directory with manifests and examples subdirectories' do
    file("#{MODULE_PATH}web_user").should be_directory
    file("#{MODULE_PATH}web_user/manifests").should be_directory
  end
end

describe "task 2:" do
  it 'define a simple web_user::user resource type' do
    file("#{MODULE_PATH}web_user/manifests/user.pp").content.should match /define\s+web_user::user/
    file("#{MODULE_PATH}web_user/manifests/user.pp").content.should match /user\s+{\s+\$title:/
    file("#{MODULE_PATH}web_user/manifests/user.pp").content.should match /file\s+{\s+/
  end
end

describe "task 3:" do
  it "create a test manifest to apply your new defined resource type" do
    file("#{MODULE_PATH}web_user/examples").should be_directory
    file("#{MODULE_PATH}web_user/examples/user.pp").content.should match /web_user::user\s+{\s*'trurl':\s*}/
  end
end

describe "task 4:" do
  it "apply your test manifest" do
    file('/home/trurl').should be_directory
    user('trurl').should exist
  end
end

describe "task 5:" do
  it "extend your web_user::user resource type to create a public_html directory and an index.html document" do
    file("#{MODULE_PATH}web_user/manifests/user.pp").content.should match /user\s+{\s+\$title:/
    file("#{MODULE_PATH}web_user/manifests/user.pp").content.should match /file\s+{.*\".*\/index\.html\".*:/
  end
end

describe "task 6:" do
  it "apply your test manifest again to create your user's public_html directory and index.html document" do
    file('/home/trurl/public_html').should be_directory
    file('/home/trurl/public_html/index.html').should be_file
  end
end

describe "task 7:" do
  it 'add $content and $password parameters to your defined resource type' do
    file("#{MODULE_PATH}web_user/manifests/user.pp").content.should match /\$content\s*=\s*"<h1>Welcome to \${title}'s home page/
    file("#{MODULE_PATH}web_user/manifests/user.pp").content.should match /\$password\s*\=\s*undef/
  end
end

describe "task 8:" do
  it 'use create_resources() function in init.pp to create users defined in "web_user::users" hiera key' do
    file("#{MODULE_PATH}web_user/manifests/init.pp").content.should match /create_resources\s*\('web_user::user',\s*(hiera(|_hash)?\s*\('web_user::users',\s*{}\s*\)|\s*\$users)\s*\)/
  end
end

describe "task 9:" do
  it 'add klapaucjusz user to hiera and set its password to "pilotpirx" and content to "Welcome to Solaris"' do
    file("/etc/puppetlabs/code/hieradata/defaults.yaml").content.should match /web_user::users:/
    file("/etc/puppetlabs/code/hieradata/defaults.yaml").content.should match /klapaucjusz:/
    file("/etc/puppetlabs/code/hieradata/defaults.yaml").content.should match /password:\s*['"]*pilotpirx['"]*/
    file("/etc/puppetlabs/code/hieradata/defaults.yaml").content.should match /content:\s*['"]*Welcome\s+to\s+Solaris['"]*/
  end
end

describe "task 10:" do
  it "apply your manifest to realize klapaucjusz user" do
    file("#{MODULE_PATH}web_user/examples/init.pp").content.should match /include\s+web_user/
    file('/home/klapaucjusz').should be_directory
    user('klapaucjusz').should exist
  end
end

