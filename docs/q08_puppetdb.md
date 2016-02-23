# Configuration Management Database

* [puppetdb](https://docs.puppetlabs.com/puppetdb/latest/) serves 2 main uses:
  * allows you to define (export) resources and realize them (collect) somewhere else (ie. different host)
    * think - export application port and import it back to load balancer
    * think - export application monitoring details and feed it to monitoring server
    * think - export your important mounts and make them backed up by backup server
  * consumes facts and reports for further inspection
    * there's excellent client-side-only puppetdb frontend called [puppet explorer](https://github.com/spotify/puppetexplorer)

# TODOs

* install puppetdb module and use it to setup puppetdb server
  * it might require bumping your vagrant memory allocation as puppetdb requires postgres and jdk to be running - 2GB should be enough
* figure out how to export ```/tmp/1.txt``` file to puppetdb w/o puppet master
* install puppet explorer and play with it
