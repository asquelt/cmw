# The most popular puppet commandline option in decade: --noop

* we'll learn how to write a portable module
  * platform-independent
  * how to test it before applying it on production

# TODOs

* create ```accounts``` module structure under ```/etc/puppetlabs/code/environments/production/modules/```
  * check ```metadata.json``` file
* design ```accounts``` class (entrypoint: ```manifests/init.pp```) so that:
  * it should accept ```$user_name``` parameter with default of ```admin```
  * on RH-like systems it puts admin in ```wheel``` group
  * on Debian-like systems it puts admin in ```sudo``` group
  * fail if neither is detected (ie. ```fail('unsupported os')```)
  * note how ```osfamily``` fact differs from ```operatingsystem```
  * prefix all facts with double colon ```::``` (ie. ```::osfamily```) to let parser know you refer to global scope variables
  * use ```notice("groups for user ${user_name} set to ${groups}")``` for debugging
* test your module
  * add a declaration in ```examples/init.pp```
  * test (```--noop```) with osfamily set to ```Debian``` (how to overwrite fact values on the fly?)
  * test (```--noop```) with osfamily set to ```RedHat``` (same trick)
  * test (```--noop```) with osfamily set to unsupported value (same trick)
* use your module to create user ```p4h``` with ```sudo``` group (ie. matching your debian/ubuntu)
