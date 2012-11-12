require "paymill/version"

module Paymill
  autoload :Client,           'paymill/resources/client'
  autoload :CreditCard,       'paymill/resources/credit_card'
  autoload :DebitCard,        'paymill/resources/debit_card'
  autoload :Offer,            'paymill/resources/offer'
  autoload :Payment,          'paymill/resources/payment'
  autoload :Preauthorization, 'paymill/resources/preauthorization'
  autoload :Refund,           'paymill/resources/refund'
  autoload :Subscription,     'paymill/resources/subscription'
  autoload :Transaction,      'paymill/resources/transaction'
  
  autoload :Scope,            'paymill/scope'
  autoload :Request,          'paymill/request'
  autoload :Resource,         'paymill/resource'
  
  module Concerns
    autoload :Naming,         'paymill/concerns/naming'
    autoload :Crud,           'paymill/concerns/crud'
    autoload :Attributes,     'paymill/concerns/attributes'
    autoload :Persistence,    'paymill/concerns/persistence'
  end
  
  class << self
    attr_accessor :api_key, :logger, :timeout

    def configure
      yield self
      self
    end
    
    def user_agent
      "paymill-ruby #{Paymill::VERSION}"
    end
    
    def environment
      ENV['RACK_ENV'] || 'development'
    end
    
    def log?
      logger && environment == 'development'
    end

    def request(method, path, payload={})
      Request.new(method, uri(path), payload).fetch
    end
    
    def uri(path=nil)
      URI::HTTPS.build(host: 'api.paymill.de', path: "/v2/#{path}")
    end   
  end
end