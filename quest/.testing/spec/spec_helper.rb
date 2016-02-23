require 'serverspec'
require 'pathname'
### include requirements ###

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

PROD_PATH = '/etc/puppetlabs/code/environments/production/'
MODULE_PATH = "#{PROD_PATH}modules/"

RSpec.configure do |c|
  if ENV['ASK_SUDO_PASSWORD']
    require 'highline/import'
    c.sudo_password = ask("Enter sudo password: ") { |q| q.echo = false }
  else
    c.sudo_password = ENV['SUDO_PASSWORD']
  end
  c.before :all do
  end
end
