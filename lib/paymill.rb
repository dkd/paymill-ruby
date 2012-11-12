require "paymill/version"

module Paymill
  autoload :Client,           'paymill/client'
  autoload :CreditCard,       'paymill/credit_card'
  autoload :DebitCard,        'paymill/debit_card'
  autoload :Offer,            'paymill/offer'
  autoload :Payment,          'paymill/payment'
  autoload :Preauthorization, 'paymill/preauthorization'
  autoload :Refund,           'paymill/refund'
  autoload :Subscription,     'paymill/subscription'
  autoload :Transaction,      'paymill/transaction'
  
  autoload :Scope,            'paymill/scope'
  autoload :Request,          'paymill/request'
  autoload :Resource,         'paymill/resource'
  
  module Concerns
    autoload :Naming,         'paymill/concerns/naming'
    autoload :Crud,           'paymill/concerns/crud'
    autoload :Attributes,     'paymill/concerns/attributes'
  end
  
  HOST = 'api.paymill.de'
  API_VERSION = 'v2'
  
  class << self
    attr_accessor :api_key, :logger, :timeout
    attr_reader :host, :api_version

    # Paymill.configure do |config|
    #   config.api_key = '1234'
    #   config.logger  = Rails.logger
    #   config.timeout = 3
    # end
        
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
      Request.new(method, path, payload).fetch
    end    
  end
end
