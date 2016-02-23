# Testing time!

* there are several tools you can utilize to test your code
** rspec - unit testing
** serverspec - acceptance testing
** beaker - automatically spawns vm and runs rspec/serverspec tests
** retrospec - generates serverspec boilerplates according to your puppet code
* quest tool uses serverspec
** play a bit with it
*** note that it uses version 1.16.0, current is 2.29.2 and api has changed!

# TODOs

* avoid cheating
** everything is stored server-side and available for inspection

# Bonus

* check out how tmux gets info about quest progress
* check out how scoreboard is updated
** please don't attempt to hack my scoreboard server, thank you ;)
