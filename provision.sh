#!/bin/bash

# install puppet
rel=https://apt.puppetlabs.com/puppetlabs-release-pc1-trusty.deb
wget -q $rel
sudo dpkg -i $(basename $rel)

# setup packages
sudo apt-get -y update
sudo apt-get -y install puppet-agent

export PATH=/opt/puppetlabs/puppet/bin/:$PATH

# provision quest
modpath=$(puppet config print modulepath|cut -f1 -d:)
ln -sf /vagrant/learning $modpath/learning
for mod in jfryman-nginx puppetlabs-apache maestrodev-wget puppetlabs-stdlib puppetlabs-concat puppetlabs-vcsrepo ; do
  puppet module install $mod
done
cat <<. | puppet apply
package { [ "vim", "git" ]: ensure => installed }
file { "/var/www": ensure => directory }
include learning
.

# tmux and quest init
ln -sf /vagrant/puppet.sh /etc/profile.d/
sudo ln -sf /vagrant/quest/.testing ~/
rm -f /vagrant/quest/.testing/log.yml

# that's all folks
echo "Type \"vagrant ssh\" to begin ;)"
