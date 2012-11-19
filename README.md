# Paymill [![Build Status](https://secure.travis-ci.org/max-power/paymill-ruby.png)](http://travis-ci.org/dkd/paymill-ruby)

A ruby wrapper for the Paymill API.

## Installation

Add this line to your application's Gemfile:

    gem 'paymill'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install paymill

## [Usage](https://github.com/max-power/paymill-ruby/wiki)

First configure Paymill by setting your API key:

```ruby    
Paymill.api_key = '123' # your private API key
```

or more fancy:
    
```ruby
Paymill.configure do |config|
  config.api_key = '1234'
  config.timeout = 3
end
```

#### Basic CRUD

```ruby
Paymill::Client.create({email: 'hi@te.am'})
Paymill::Client.find(id)
Paymill::Client.update(id, {email: 'hallo@te.am'})
Paymill::Client.delete(id)
Paymill::Client.delete_all
```

#### Advanced Queries 

```ruby
Paymill::Client.all
Paymill::Client.count
Paymill::Client.where(email: 'hi@te.am').limit(2).offset(10).first
Paymill::Client.order(:description, :desc).last(3)
Paymill::Client.where(email: '@gmail.com').order(:date_created, :desc).delete_all
```

Use <tt>scoped</tt>, <tt>where</tt>, <tt>order</tt>, <tt>limit</tt>, <tt>offset</tt>, <tt>paginate</tt> 
to build up chainable query scopes.  
These methods will return a <tt>Paymill::Scope</tt> object.

Use <tt>all</tt>, <tt>each</tt>, <tt>first</tt>, <tt>last</tt>, <tt>count</tt>, <tt>total</tt>, <tt>empty?</tt>
and all methods from <tt>Enumerable</tt> module on the scope to trigger a query to the Paymill API.

#### Instance Methods

```ruby
client = Paymill::Client.new(email: 'christane@mai.se')
client.new? # true
client.save # create  TODO: not working
client.new? # false
client.description = 'A new client'
client.save # update  TODO: not working
client.delete # delete

client.subscribe!(offer_id, payment_id)
```

```ruby
transaction = Paymill::Transaction.find('trans_1243124234')
transaction.refundable?
transaction.refund!(2000, 'Refund 20 EUR')
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
