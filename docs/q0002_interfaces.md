# Command line!

* puppet 4 does a good job on exposing its components with single "puppet" command, ie.
 * ```puppet facts``` - will 
* unfortunately ```puppet help``` is not that great
 * [documentation is awesome](https://docs.puppetlabs.com/puppet/)
 * especially [type reference](https://docs.puppetlabs.com/puppet/latest/reference/type.html) and [cheat sheet](https://docs.puppetlabs.com/puppet_core_types_cheatsheet.pdf)
  * note that it uses version 1.16.0, current is 2.29.2 and api has changed!

# TODOs

* explore ```puppet``` command
 * ```puppet facts```
  * but note it's impossible to get single fact - use ```facter``` to get just ```ipaddress``` fact
 * ```puppet lookup```
  * check for hiera key ```puppet_enterprise::profile::puppetdb::listen_address``` - where is it stored? change it to 127.0.0.1
  * how it's different from calling ```hiera puppet_enterprise::profile::puppetdb::listen_address``` directly?
  * try to debug both!
 * ```puppet resource```
  * change GECOS for user root by editing it inline
  * list all /etc/hosts entries
 * ```puppet cert```
  * generate certificate for ```foo.acme.com```
  * list all certificates known to your local CA

# Bonus

* try to find easter egg by requesting ```puppet help``` on module ```help``` submodule ```help``` with some ```help``` arguments :D
