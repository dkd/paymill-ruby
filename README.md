![PAYMILL icon](https://static.paymill.com/r/335f99eb3914d517bf392beb1adaf7cccef786b6/img/logo-download_Light.png)

paymill-ruby
============

Ruby wrapper for PAYMILL API inspired by [dkd's paymill-ruby](https://github.com/dkd/paymill-ruby)

[![Build Status](https://travis-ci.org/paymill/paymill-ruby.svg)](https://travis-ci.org/paymill/paymill-ruby) [![Code Climate](https://codeclimate.com/github/paymill/paymill-ruby/badges/gpa.svg)](https://codeclimate.com/github/paymill/paymill-ruby)

Getting started
===============

-	If you are not familiar with PAYMILL, start with the [documentation](https://www.paymill.com/en-gb/documentation-3/).
-	Install the latest release.
-	Check the API [reference](https://www.paymill.com/en-gb/documentation-3/reference/api-reference/).
-	Check the specification examples.
-	Take a loog at the [change log](./CHANGELOG.md) for recent updates and improvements.

Installation
============

Add this line to your application's Gemfile:

```ruby
gem 'paymill', git: 'git://github.com/paymill/paymill-ruby.git'
```

And then execute:

```
$ bundle
```

Or install it yourself as:

```
$ gem install paymill
```

The paymill gem is tested on Ruby 1.9.3, 2.0.0, 2.1.0, 2.1.3 and 2.1.5. It requires ruby 1.9.3+

Usage
=====

Initialize the library by providing your api key:

```ruby
Paymill.api_key = '<YOUR PRIVATE API KEY>'
```

or by reading it from the envirounment variables

```ruby
Paymill.api_key = ENV['PAYMILL_API_TEST_KEY']
```

Clients
-------

#### Creating clients

Creating via factory method **create**, which expects an optional hash as arguments. If some of the required attributes are missing the method will throw **ArgumentError**.

-	with a hash of optional arguments:

```ruby
client = Paymill::Client.create( email: 'john.rambo@qaiware.com', description: 'Main caracter in First Blood' )
```

-	without arguments:

```ruby
client = Paymill::Client.create
```

#### Find/refresh existing client

You can retrieve an object by using the **find** method with an object id:

```ruby
client = Paymill::Client.find( 'client_b54ff8b3811e06c02e14' )
```

or with the instance itself, which also refreshes it:

```ruby
client = Paymill::Client.find( client )
```

#### Update client

Update is done by modifying the instance variables of the object. The object itself provides accessor methods only for properties which can be updated.

```ruby
client = Paymill::Client.find( 'client_b54ff8b3811e06c02e14' )

client.email = 'john.rambo.2@qaiware.com'
client.description = 'Main caracter in First Blood II'

client = Paymill::Client.update( client )
```

#### Deleting client

You may delete objects by calling the class **delete** method with an object instance or object id.

```ruby
Paymill::Client.delete( client )
```

```ruby
Paymill::Client.delete( 'client_b54ff8b3811e06c02e14' )
```

#### Retrieving lists

To retrieve a list you may simply use the **all** class method

```ruby
clients = Paymill::Client.all
```

You may provide filter, order, offset and count parameters to list method

```ruby
clients = Paymill::Client.all( order: [:email, :created_at_desc], count: 30, offset: 10, filters: [email: 'john.rambo@qaiware.com', created_at: "#{4.days.ago.to_i}-#{2.days.ago.to_i}"] )
```

Contributing
============

1.	Fork it ( https://github.com/paymill/paymill-ruby/fork )
2.	Create your feature branch (`git checkout -b my-new-feature`)
3.	Commit your changes (`git commit -am 'Add some feature'`)
4.	Push to the branch (`git push origin my-new-feature`)
5.	Create a new Pull Request
