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

Clients
-------

*[Paymill documentation on clients](https://www.paymill.com/en-gb/documentation-3/reference/api-reference/#clients)*

Creating a new client:

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


Offers
------

*[Paymill documentation on offers](https://www.paymill.com/en-gb/documentation-3/reference/api-reference/#offers)*

Creating a new offer:

    Paymill::Offer.create(name: "Monthly", interval: "1 month", amount: 1000, currency: "GBP", trial_period_days: 0)

Updating an offer (works on an Offer instance and only the name can be changed):

    offer = Paymill::Offer.find("offer_08064e30032afa3aa046")
    offer.update_attributes(name: "New name")

Deleting an offer:

    Paymill::Offer.delete('offer_08064e30032afa3aa046')

Retrieving an offer:

    Paymill::Offer.find("offer_753480df39aeb114f2f3")

Retrieving all offers:

    Paymill::Offer.all


Webhooks
------

*[Paymill documentation on webhooks](https://www.paymill.com/en-gb/documentation-3/reference/api-reference/#webhooks)*

Creating a new webhook:

    Paymill::Webhook.create(email: "email@bob.com", event_types: ["transaction.succeeded", "subscription.succeeded"])

Updating a webhook works on an instance (url/email and the event types can be changed):

    hook = Paymill::Webhook.find("hook_940143bcdc0c40e7756f")
    hook.update_attributes(email: "bob@email.com")

Deleting a webhook:

    Paymill::Webhook.delete("hook_940143bcdc0c40e7756f")

Retrieving a webhook:

    hook = Paymill::Webhook.find("hook_940143bcdc0c40e7756f")

Retrieving all webhooks:

    Paymill::Webhook.all


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
