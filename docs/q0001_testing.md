# Testing time!

* there are several tools you can utilize to test your code
  * rspec - unit testing
  * serverspec - acceptance testing
  * beaker - automatically spawns vm and runs rspec/serverspec tests
  * retrospec - generates serverspec boilerplates according to your puppet code
* quest tool uses serverspec
  * play a bit with it
    * note that it uses version 1.16.0, current is 2.29.2 and api has changed!

# TODOs

* avoid cheating
  * just use hints if you get stuck ;)
  * scoreboard is stored server-side and available for inspection
* think how you could use serverspec in your environment
  * it's completely independent of puppet, and in fact used by many others CM tools ([ansible](http://sharknet.us/2014/02/04/infrastructure-testing-with-ansible-and-serverspec-part-1/), [chef](http://kitchen.ci/))

# Bonus

* check out how tmux gets info about quest progress
* [check out how scoreboard is updated](../scoreboard/p4h/index.php)
  * please don't attempt to hack my scoreboard server, thank you ;)
  * please don't publish ghosts, only humans!
