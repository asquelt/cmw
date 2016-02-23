# Challenge yourself!

* write another quest
  * submit pull request
    * you and your collegues can earn some more points now!
* or: submit a bug fix and ask me for some extra points :)
* or: submit a wonderful idea and ask me for some extra points :)
* or: make a lighting talk and ask me for some extra points :)

* but most importantly:
  * have fun!

# Bonus

* some quest and/or challenge ideas:
  * ```augeas``` provider (beware! it's powerful! learn use it properly, otherwise it's going to slow you down!)
  * bind ```mount``` fun
  * exploit numerous ```exec``` parameters (but try to avoid ```exec``` irl if possible!)
  * variables scoping, ordering and inheritance issues
  * virtual resources, why they're useful?
  * secure password store or generators (eyaml, vault, trocla)
  * letsencrypt.com support
  * play with file manipulation (```inifile```, ```file_line```, ```concat```)
  * hack with data manipulation (```inline_template```, ```parseyaml```)
  * new epp (embedded puppet) templating engine
  * write a fact (native ruby and/or external fact - but note that external facts cannot call other facts!)
  * write a function
  * design hierarchical firewall with puppet
  * play with hardening modules (can you find [trusted ones?](https://github.com/NationalSecurityAgency/SIMP))
  * discuss how to clean old resources when they're removed from manifest or node classification changes
  * create a certificate with PSK or machine UUID (virtual) - validate it automatically on puppet master (think: secure auto sign!)
  * build load balancer (ie. with haproxy) which accepts backends automatically (with exported resources or [pdbquery](https://github.com/dalen/puppet-puppetdbquery))
  * design a solution where no more than 20 machines are asking puppet master for manifest at the same time
