# Paymill

A ruby wrapper for the paymill api.

## Installation

Add this line to your application's Gemfile:

    gem 'paymill'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install paymill

## Usage

First configure Paymill by setting your API key:

```ruby    
Paymill.api_key = '123' # your private API key
```

or more fancy:
    
```ruby
Paymill.configure do |config|
  config.api_key = '1234'
  config.logger  = Rails.logger
  config.timeout = 3
end
```

Some query examples:  

```ruby
Paymill::Client.find(id)
Paymill::Client.all
Paymill::Client.count
Paymill::Client.where(email: 'hi@te.am').limit(2).offset(10).first
Paymill::Client.order(:description, :desc).last(3)

Paymill::Client.create({email: 'hi@te.am'})
Paymill::Client.update(id, {email: 'hallo@te.am'})
Paymill::Client.delete(id)
Paymill::Client.delete_all
    
client = Paymill::Client.new(email: 'christane@mai.se')
client.new? # true
client.save # create
client.new? # false
client.description = 'A new client'
client.save # update
client.destroy # delete
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
