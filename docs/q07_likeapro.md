# Manage Puppet Code like a Pro

* so we have some diverse sources of our modules
  * puppet forge
  * github
  * (possibly) our private repositories with modules
    * note it's a good idea to keep one-module-per-repository schema, so different teams may focus on what they can do best
* [r10k](https://docs.puppetlabs.com/pe/latest/r10k.html) is a robot which answers this problem
  * create control repository
  * create as many branches as you want
  * put different combinations of modules and versions in those branches
  * execute r10k and observe how it creates puppet environment based on Puppetfile defined in each of your branches
    * please note that branch names must be purely alphanumeric, as puppet doesn't support environment names with dashes, underscores, etc.
  * note other things that it to control repo
    * per-branch hiera data
    * environment.conf
    * global (called for historical reasons: site) manifest

# TODOs

* install r10k module
* create "puppet-control" repository in /var/lib/git
* install and configure r10k to use given control repository
* commit Puppetfile to "puppet-control" repository 
  * add some forge and some github modules to p4h branch
* create p4h puppet environment with r10k
  * you might want to link from ```/opt/quest/gems/gems/r10k-1.5.1/bin/r10k``` to ```/usr/bin/r10k```
* create a "legacy" branch with some other versions (refs or semvers) of the same modules
* create legacy puppet environment with r10k
* make a hook so r10k updates puppet ater every commit to "puppet-control" repository
