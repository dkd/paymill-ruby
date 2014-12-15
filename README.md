![PAYMILL icon](https://static.paymill.com/r/335f99eb3914d517bf392beb1adaf7cccef786b6/img/logo-download_Light.png)

paymill-ruby
============

Ruby wrapper for PAYMILL API forked by [dkd's paymill-ruby](https://github.com/dkd/paymill-ruby)

[![Build Status](https://travis-ci.org/paymill/paymill-ruby.svg)](https://travis-ci.org/paymill/paymill-ruby) [![Code Climate](https://codeclimate.com/github/paymill/paymill-ruby/badges/gpa.svg)](https://codeclimate.com/github/paymill/paymill-ruby)

Getting started
===============

-	If you are not familiar with PAYMILL, start with the [documentation](https://www.paymill.com/en-gb/documentation-3/).
-	Install the latest release.
-	Check the API [reference](https://www.paymill.com/en-gb/documentation-3/reference/api-reference/).
-	Check the specification examples.
-	Take a look at the [change log](./CHANGELOG.md) for recent updates and improvements.

Installation
============

Add this line to your application's Gemfile:

```ruby
gem 'paymill', git: 'git://github.com/paymill/paymill-ruby.git'
```

Or install it yourself as:

```
$ gem install paymill_ruby
```

And then execute:

```
$ bundle
```

The paymill gem is tested on Ruby 1.9.3, 2.0.0, 2.1.0, 2.1.3 and 2.1.5. It requires ruby version 1.9.3+

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

With a hash of optional arguments:

```ruby
client = Paymill::Client.create( email: 'john.rambo@qaiware.com', description: 'Main caracter in First Blood' )
```

Without mandatory arguments:

```ruby
client = Paymill::Client.create
```

#### Find existing client

You can retrieve an object by using the **find** method with an object id:

```ruby
client = Paymill::Client.find( 'client_b54ff8b3811e06c02e14' )
```

or with the instance itself:

```ruby
client = Paymill::Client.find( client )
```

#### Update client

Update is done by modifying the instance variables of the object. The object itself provides accessor methods only for properties which can be updated.

```ruby
client = Paymill::Client.find( 'client_b54ff8b3811e06c02e14' )

client.email = 'john.rambo.2@qaiware.com'
client.description = 'Main caracter in First Blood II'

client.update
```

#### Deleting client

You may delete objects by calling the its instance method **delete**. The delete method will return <code>nil</code> when the given object is removed successfully.

```ruby
client = Paymill::Client.find( 'client_b54ff8b3811e06c02e14' )
client.delete
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

Offer
-----

#### Update offer

When you want to update the offer and to apply the new changes to its subscriptions you can pass an additional parameter <code>update_subscriptions</code> set to <code>true</code> to its instance method **update**

```ruby
offer = Offer.find( 'offer_b54ff8b3811e06c02e14' )
offer.amount = 1000

offer.update( update_subscriptions: true )
```

#### Deleting offer

To delete an offer and its corresponding subscriptions call

```ruby
offer = Offer.find( 'offer_b54ff8b3811e06c02e14' )
offer.delete_with_subscriptions()
```

To delete an offer but leave its corresponding subscriptions call

```ruby
offer = Offer.find( 'offer_b54ff8b3811e06c02e14' )
offer.delete_without_subscriptions
```

To delete an offer and its corresponding subscriptions you can call the instance method **delete** with an argument <code>remove_with_subscriptions</code> set to <code>true</code>

```ruby
offer = Offer.find( 'offer_b54ff8b3811e06c02e14' )
offer.delete( remove_with_subscriptions: true )
```

Refund
------

#### Creating refunds

To create a refund you have to pass a transaction, which you want to be refunded.

```ruby
transaction = Transaction.create( token: '098f6bcd4621d373cade4e832627b4f6', amount: 990, currency: 'EUR' )
refund = Refund.create( transaction, amount: 100 )
```

Subscription
------------

Contributing
============

1.	Fork it ( https://github.com/paymill/paymill-ruby/fork )
2.	Create your feature branch (`git checkout -b my-new-feature`)
3.	Setup the project (`bundle install`)
4.	Setup PAYMILL's test key in your environment (`export PAYMILL_API_TEST_KEY="<YOUR_TEST_KEY>"`)
5.	Run all the tests (`rspec .)` or a subset from them (`rspec ./spec/paymill/models/client_spec.rb`)
6.	Commit your changes (`git commit -am 'Add some feature'`)
7.	Push to the branch (`git push origin my-new-feature`)
8.	Create a new Pull Request
