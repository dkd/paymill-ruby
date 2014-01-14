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

## Configuration

You can also set the API version, base endpoint and port:

    Paymill.api_version = 'v1'
    Paymill.api_base = '0.0.0.0'
    Paymill.api_port = 3000

### Development Mode

This gem also has a development mode in which HTTP requests are made, instead of
HTTPS, you can turn in on like this:

    Paymill.development = true # false by default

### Logging

Out of the box paymill-ruby will log all requests and responses to `STDOUT`, you
can use any logger you want, though:

    Paymill.logger = Logger.new(STDERR)

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

Payments
-------

*[Paymill documentation on payments](https://www.paymill.com/en-gb/documentation-3/reference/api-reference/#document-payments)*

Creating a new credit card payment:

    Paymill::Payment.create(token: "098f6bcd4621d373cade4e832627b4f6")

Creating a new debit card payment:

    Paymill::Payment.create(type: "debit", code: "12345678", account: "1234512345", holder: "Max Mustermann")

Or finding an existing payment:

    Paymill::Payment.find("pay_3af44644dd6d25c820a8")

Deleting a payment:

    Paymill::Payment.delete("pay_3af44644dd6d25c820a8")


For retrieving a collection of all payments you might use the `all`
operation:

    Paymill::Payment.all

Transactions
-----------

*[Paymill documentation on transactions](https://www.paymill.com/en-gb/documentation-3/reference/api-reference/#transactions)*

A transaction can be executed as following

    params = {
        :amount => 2000, # cents. Must be an integer
        :currency => 'USD', # iso
        :client => 'client_123', # client id. Use 'Paymill::Client'
        :payment => 'payment_123', # payment id. Use 'Paymill::Payment'
        :description => "some comment if needed"
    }
    Paymill::Transaction.create(params)

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


Refunds
------

*[Paymill documentation on refunds](https://www.paymill.com/en-gb/documentation-3/reference/api-reference/#refunds)*

Creating a new refund:

    Paymill::Refund.create(id: "tran_023d3b5769321c649435", amount: 4200)

Retrieving a refund:

    refund = Paymill::Refund.find("refund_87bc404a95d5ce616049")

Retrieving all refunds:

    Paymill::Refund.all


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
