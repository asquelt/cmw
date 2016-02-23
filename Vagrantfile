Vagrant::Config.run do |config|
  config.vm.box = "puppetlabs/ubuntu-14.04-64-nocm"
  config.vm.provision :shell, :path => "provision.sh"
  #config.vm.forward_port 9090, 9090
end
