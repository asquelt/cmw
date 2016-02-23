require 'spec_helper'

describe "task 1:" do
  it 'install WhatsARanjit-vim module' do
    file("#{MODULE_PATH}vim").should be_directory
    file("#{MODULE_PATH}vim/metadata.json").should contain 'WhatsARanjit-vim'
  end
end

describe "task 2:" do
  it 'apply vim profile to root user' do
    file('/usr/bin/vim').should be_file
    file("/root/.vim").should be_directory
  end
end

describe "task 3:" do
  it 'install supported mysql module' do
    file("#{MODULE_PATH}mysql").should be_directory
    file("#{MODULE_PATH}mysql/metadata.json").should contain 'puppetlabs-mysql'
  end
end

describe "task 4:" do
  it 'define the mysql class in /root/mysql.pp; set root password and bump max_connections to 250' do
    file("/root/mysql.pp").content.should match /class\s*{\s*'(::)?mysql::server':/
    file("/root/mysql.pp").content.should match /\s*root_password\s+=>\s+/
    file("/root/mysql.pp").content.should match /\s*override_options\s+=>\s+/
    file("/root/mysql.pp").content.should match /'max_connections'\s+=>\s+'250'/
  end
end

describe "task 5:" do
  it 'apply /root/mysql.pp manifest' do
    file('/usr/bin/mysql').should be_file
  end
end

describe "task 6:" do
  it "add mysql::server::account_security class in /root/mysql.pp" do
    file('/usr/bin/mysql').should be_file
    command("mysql -e \"show grants for 'root'@'::1';\"|grep GRANT").exit_status.should_not be_zero
  end
end

describe "task 7:" do
  it "create new p4h database, p4h user, and grant with puppet in /root/mysql.pp" do
    command("mysql -e 'show databases;'|grep p4h").exit_status.should be_zero
    command("mysql -e 'SELECT User FROM mysql.user;'|grep p4h").exit_status.should be_zero
    command("mysql -e 'show grants for p4h@localhost;'|grep p4h.*").exit_status.should be_zero
  end
end
