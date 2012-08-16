Paymill
======

This is a Ruby wrapper for Paymill's API.

Usage
======

First, you've to install the gem

    gem install paymill

and require it

    require "paymill"

Then you have to set your public API key:

    Paymill.api_key = "your-public-api-key"

You can create clients as following:

    Paymill::Client.create(email: "stefan.sprenger@dkd.de", description: "He is a Ruby guy.")

You can create a credit card as following:

    Paymill::CreditCard.create(token: "token_8349fjh89qp3849h")

This returns a new `Paymill::Client` object.

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

Copyright (c) 2012 dkd Internet Service GmbH, Stefan Sprenger. See LICENSE for details.