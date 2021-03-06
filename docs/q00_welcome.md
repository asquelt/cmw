# Welcome!

* since version 4 puppet now uses semantic versioning for it's packages
* x.y.z
  * x = api change
  * y = new features
  * z = bug and security fixes
* it also uses all in one (AIO) packaging
  * ie. ruby interpreter is bundled
  * no more legacy ruby bundled with os
  * we can run faster!

# TODOs

* check puppet and ruby version
  * puppet should be on path (```which puppet```), check where ruby is with ```dpkg```
* discover quest robot
  * try to discover command line
  * track your progress
  * the whole quest idea comes from [puppet learning vm](https://github.com/puppetlabs/courseware-lvm/blob/master/Quest_Guide/)
    * but we'll use only opensource components!
    * to save some memory, we won't be using puppet-server (jdk/clojure app, requires 4GB)
      * you can still play with it, by [downloading puppet learning vm](https://puppetlabs.com/download-learning-vm)

# Bonus

* check out how puppet announces security updates
  * and how to report issues to them
* check out how they track their tickets

# Next

* we'll learn how quest evaluates your progress
  * let's go: ```quest --start Q01_testing```
