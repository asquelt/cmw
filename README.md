# Configuration Management Workshop 2016 - Google Campus Warsaw - Puppet for Hackers Quest

## Setup

* Please clone this repo and do ```vagrant up```
** Please let it run for 5 minutes or so, other guys requested box w/o puppet agent installed to learn people how to do it (if you're curious look into [provisioning](./provision.sh) script)
** If you've followed Jacob's instructions prior to the event, you should be covered
** If not, download [virtualbox](https://www.virtualbox.org/), [vagrant](https://www.vagrantup.com/) and wait some more time while box is being pulled while everybody else does the same :D

## If anything breaks

* Please ask me
** I had to adjust some modules a bit to run on ubuntu (Puppetlabs uses centos)

## Do some hacking

* Login as root (```vagrant ssh``` and ```sudo -i```)
* Run your 1st quest (```quest --start Q0000_welcome``` and ```quest --progress```)
* Check out some more (```quest --list```)
* Enjoy!

## Do some networking

* Don't be afraid to ask presenters (in person or with [slack](https://cmw2016.slack.com/)) for:
** Configuration Management Tools use cases
** Ad-hoc demos
** Devops methodologies and tools ecosystem
** Cool users/contributors events
* Grab a coffee or beer
* Have fun!

## Contributions

* Fork
* Hack
* Send me a pull request
* And shout at event's [slack](https://cmw2016.slack.com/messages/p4h/)!
