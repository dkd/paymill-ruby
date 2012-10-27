Paymill ![Build status](http://secure.travis-ci.org/dkd/paymill-ruby.png)
======

This is a Ruby wrapper for Paymill's API.

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

Or find a existing client:

    Paymill::Client.find("client_88a388d9dd48f86c3136")

For retrieving a collection of all clients you might use the `all`
operation:

    Paymill::Client.all

We currently only support the operations `create`, `find` and `all`.

Requirements
=====

This gem was developed using Ruby 1.9 and version 1 of Paymill's API. Nonetheless, it should also work with Ruby 1.8.

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
