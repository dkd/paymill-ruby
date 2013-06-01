require "net/http"
require "net/https"
require "json"
require "paymill/version"
require "pry"

module Paymill
  API_BASE    = "api.paymill.com"
  API_VERSION = "v2"
  ROOT_PATH   = File.dirname(__FILE__)

  @@api_key = nil

  autoload :Base,             "paymill/base"
  autoload :Client,           "paymill/client"
  autoload :Offer,            "paymill/offer"
  autoload :Payment,          "paymill/payment"
  autoload :Preauthorization, "paymill/preauthorization"
  autoload :Refund,           "paymill/refund"
  autoload :Subscription,     "paymill/subscription"
  autoload :Transaction,      "paymill/transaction"
  autoload :Webhook,          "paymill/webhook"

  module Operations
    autoload :All,    "paymill/operations/all"
    autoload :Create, "paymill/operations/create"
    autoload :Find,   "paymill/operations/find"
    autoload :Update, "paymill/operations/update"
    autoload :Delete, "paymill/operations/delete"
  end

  module Request
    autoload :Base,        "paymill/request/base"
    autoload :Info,        "paymill/request/info"
  end

  class PaymillError < StandardError; end
  class AuthenticationError < PaymillError; end
  class APIError            < PaymillError; end

  # Returns the set api key
  #
  # @return [String] The api key
  def self.api_key
    @@api_key
  end

  # Sets the api key
  #
  # @param [String] api_key The api key
  def self.api_key=(api_key)
    @@api_key = api_key
  end

  # Makes a request against the Paymill API
  #
  # @param [Symbol] http_method The http method to use, must be one of :get, :post, :put and :delete
  # @param [String] api_url The API url to use
  # @param [Hash] data The data to send, e.g. used when creating new objects.
  # @return [Array] The parsed JSON response.
  def self.request(http_method, api_url, data)
    info = Request::Info.new(http_method, api_url, data)
    Request::Base.new(info).send
  end
end
