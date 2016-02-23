# Puppet Holy Trinity

* 90% of puppet jobs can be acomplished by 3 builtin resource types:
  * ```package``` - first thigs first: we need to install sth
  * ```file```- then: configure it
  * ```service``` - finally: start it (and preferably keep it this way)
* check [type reference](https://docs.puppetlabs.com/puppet/latest/reference/type.html) and learn what those types can do for you, ie.
  * recursive directories
  * files auditing capabilities
  * multiple install providers (gem, pip, more in modules) apart from you default os pkg provider
  * how to reload service on config changes, instead of restarting it
* take a look at [useful metaparameters](https://docs.puppetlabs.com/puppet/latest/reference/metaparameter.html) which can be applied to any resource type
  * especially those modelling resource relationships

# TODOs

* build ```sshd``` module (```/etc/puppetlabs/code/environments/production/modules/```)
  * create module skeleton
  * create sshd class which installs sshd package and starts service
  * create test manifest (```examples/init.pp```), apply it + generate relationship graphs
  * use graphviz (```dot```) to make a visible image of resource relationships
    * copy over this image and check it out (you can use mapped ```/vagrant``` directory on your vagrant host)
  * create ```sshd_config``` file resource and set it to file templated from your system's ```/etc/ssh/sshd_config```
    * you can use ```source => 'puppet:///...'``` notation or use ```template()``` function
      * which is more flexible?
      * which is more resource-hungry?
      * which is more secure?
  * edit your puppet template to disable GSSAPI authentication
  * do a smoke test + generate relationship graphs
  * add a ```subscribe``` metaparameter to your ```sshd``` resource to restart your sshd server on config changes automagically
  * apply configuration, oberve how sshd PID changed
