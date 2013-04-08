Paymill [![Build Status](https://secure.travis-ci.org/dkd/paymill-ruby.png)](https://travis-ci.org/dkd/paymill-ruby)
======

This is a Ruby wrapper for Paymill's API.

Documentation
=====

We use RubyDoc for documentation.

The documentation of the current release can be found here:
http://rubydoc.info/gems/paymill/frames/index

Usage
======

First, you've to install the gem

    gem install paymill

and require it

    require "paymill"

Then you have to set your API key:

    Paymill.api_key = "your-api-key"

Now you can e.g. create a new client:

    Paymill::Client.create(email: "stefan.sprenger@dkd.de", description: "He is a Ruby guy.")

Or find an existing client:

    Paymill::Client.find("client_88a388d9dd48f86c3136")

Updating an existing client only works on an instance:

    client = Paymill::Client.find("client_88a388d9dd48f86c3136")
    client.update_attributes(email: "carl.client@example.com")

Deleting a client:

    Paymill::Client.delete("client_88a388d9dd48f86c3136")


For retrieving a collection of all clients you might use the `all`
operation:

    Paymill::Client.all

To sort and filter collection lists of objects, use the `all` method
with an options hash. For example to find the most recent transactions
belonging to a client you can use the following code:
    
    Paymill::Transaction.all(client: "<client_id>", order: "created_at_desc")

Please note that Transactions and Payments cannot be updated.

Requirements
=====

This gem requires Ruby 1.9 and faces version 2 of Paymill's API.

Bugs
======

Please report bugs at http://github.com/dkd/paymill-ruby/issues.

Note on Patches/Pull Requests
======

* Fork the project from http://github.com/dkd/paymill-ruby.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

Copyright
======

Copyright (c) 2012-2013 dkd Internet Service GmbH, Stefan Sprenger. See LICENSE for details.
