# Lobstr

deployments so easy, even a zoidberg can do it.

![why not lobstr?](http://f.cl.ly/items/0S392f3e3f00373A2l3Y/why-not-lobstr.jpg)

## Installation

Add this line to your application's Gemfile:

    gem 'lobstr'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install lobstr

## Usage
   
````bash
$ lob deploy branch@environment
````

For your convenience, lobstr supports additional syntax you may find
useful:

````bash
# without task name, but full branch and environment
$ lob branch@environment

# without task name or environment, currently defaults to "production"
$ lob branch@

# without task name or branch, currently defaults to "master"
$ lob @producuction

# without task name or branch (alt. syntax), currently defaults to "master"
$ lob production

# without any input, currently defaults to "master@production"
$ lob
````

## Configuration

*Coming soon*

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
