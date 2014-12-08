require 'json'
require 'net/https'
require 'active_support/time'
require 'active_support/core_ext/string'
require 'active_support/core_ext/numeric/time'
require "paymill/version"
require 'paymill/errors'
require 'paymill/restful/methods'

module Paymill
  API_VERSION   = 'v2.1'
  API_BASE      = 'api.paymill.com'

  autoload :Base,                 'paymill/models/base'
  autoload :Client,               'paymill/models/client'
  autoload :Fee,                  'paymill/models/fee'
  autoload :Invoice,              'paymill/models/invoice'
  autoload :Merchant,             'paymill/models/merchant'
  autoload :Offer,                'paymill/models/offer'
  autoload :Payment,              'paymill/models/payment'
  autoload :PaymentMethod,        'paymill/models/payment_method'
  autoload :Preauthorization,     'paymill/models/preauthorization'
  autoload :Refund,               'paymill/models/refund.rb'
  autoload :Subscription,         'paymill/models/subscription'
  autoload :SubscriptionCount,    'paymill/models/subscription_count'
  autoload :Transaction,          'paymill/models/transaction'
  autoload :Webhook,              'paymill/models/webhook'

  def self.api_version
    API_VERSION
  end

  def self.api_key
    @@api_key
  end

  def self.api_key=( api_key )
    @@api_key = api_key
  end

  def self.request( payload )
    raise AuthenticationError unless Paymill.api_key
    https ||= Net::HTTP.new( API_BASE, Net::HTTP.https_default_port)
    https.use_ssl = true

    response = https.start do
      https.request( payload )
    end

    raise PaymillError, response.body unless response.class.eql? Net::HTTPOK

    JSON.parse( response.body )
  end

end
