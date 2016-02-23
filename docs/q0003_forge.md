# Meet the universe!

* [puppet forge](https://forge.puppetlabs.com/) allows you to browse nearly 4k ready to use modules! (think [supermarket](https://supermarket.chef.io/) or [galaxy](https://galaxy.ansible.com/) for puppet)
  * don't use puppet 3 - some forge modules are already migrated to "future-is-now" parser syntax
* write puppet code with style!
  * check support for your favorite editor ([atom](https://github.com/asquelt/atom-puppet), [vim](https://forge.puppetlabs.com/WhatsARanjit/vim), [textmate](https://github.com/masterzen/puppet-textmate-bundle), etc)
  * check out [puppet style guide](https://docs.puppetlabs.com/guides/style_guide.html)
* look how modules are being designed
  * idempotent - you can apply manifest numerous times and outcome doesn't change
    * puppet language models end state (declaration) not process (function)
  * clear module layout
    * ```puppet module generate``` will provide it for you
    * [several nice module skeletons available](https://github.com/garethr/puppet-module-skeleton)
  * [platform (and mysql flavor) independent](https://github.com/puppetlabs/puppetlabs-mysql/blob/master/manifests/params.pp)
    * new data-in-modules feature will make those params.pp finally go away
  * [with clear class-to-class relationships](https://github.com/puppetlabs/puppetlabs-mysql/blob/master/manifests/server.pp)
    * Class[a]->Class[b] dash-arrow provides relationship
    * Class[b]~>Class[c] tilde-arrow provides refresh (say: remounts mountpoints, reloads services in Class[c] when Class[b] changes)
    * Anchor[start] and Anchor[stop] allow you to bookend your classes
  * [modules are provided with sane security configuration](https://github.com/puppetlabs/puppetlabs-mysql/blob/master/manifests/server/account_security.pp)
    * but sometimes - like here - you'd need to opt-in to use them

# TODOs

* install WhatsARanjit-vim module
  * apply it for root with ```puppet apply -e 'package { 'ruby': ensure => installed } ; include vim; vim::vim_profile { 'root': }'```
    * note how you can use handy code oneliners with puppet 4 "future-is-now" parser
  * now your vim will highlight syntax and validate code for you on save!
    * you might need to make your puppet-lint global for vim: ```ln -s /opt/quest/gems/gems/puppet-lint-1.1.0/bin/puppet-lint /usr/bin/puppet-lint```
  * so we can safely move on to write our code...
* install supported mysql module with forge
* configure mysql in ```/root/mysql.pp``` and enforce it (masterless) with ```puppet apply```
  * set secure (think: d*pa.8) password to mysql root user
  * set max limit of connections to 250
  * remove insecure default accounts and test database
  * create p4h db/user and give a grant - all using resource types provided by mysql module
