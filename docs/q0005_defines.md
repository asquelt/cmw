# Defining policies with defined resource types

* ```define``` works just like a ```class```, but can be called multiple times (not a singleton)
* magic ```$title``` variable refers to define indentifier
  * like in all puppet resources: *resource type* and *resource title* must be unique globally in your manifests
    * so it's wise to name resources inside ```define``` using ```$title``` (or concatenated ```$title```)
* ```create_resources('type', $resources_hash, $defaults_hash)``` is quite powerful
  * you can feed data from hiera and directly map them to resources
    * think like: ```file { [ '/tmp/1', '/tmp/2', '/tmp/3' ]: }``` but with whole argument set, say:

```
---
my_files:
  '/tmp/1':
    owner: 'root'
    group: 'root'
    mode: '0644'
    content: 'This is file one.'
  '/tmp/2':
    owner: 'joe'
    group: 'users'
    mode: '0600'
    content: 'This is file foo.'
  '/tmp/3':
    owner: 'nobody'
    group: 'nobody'
    mode: '0640'
    content: 'This is file nobody likes.'
...
```

* try it and you'll love it <3

# TODOs

* create the web_user module skeleton (```/etc/puppetlabs/code/environments/production/modules/```)
* make web_user::user resource type
  * it should create user with name ```$title``` and homedir set to ```/home/${title}``` (watch out style guide and variable interpolation!)
  * smoke test it
  * make ```trurl``` web user
  * extend the model so that index in webroot (```public_html/index.html```) is created automagically from macro: ```<h1>Welcome to ${title}'s home page!</h1>```
  * extend it so that ```$content``` (webpage index default content) and ```$password``` may be set when called
  * rinse and repeat
  * use ```create_resources()``` so that ```klapaucjusz``` user is being fed from hiera's ```web_user::users``` key
* note how - when creating directory and user puppet automatically adds dependency (always creates owner, then directory) - same with one directory contained in the other (order will be enforced)
