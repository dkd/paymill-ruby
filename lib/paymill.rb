require "net/http"
require "net/https"
require "json"
require "paymill/version"
require "logger"

module Paymill
  API_BASE      = "api.paymill.com"
  API_VERSION   = "v2"
  ROOT_PATH     = File.dirname(__FILE__)

  @@api_key     = nil
  @@api_base    = API_BASE
  @@api_version = API_VERSION
  @@api_port    = Net::HTTP.https_default_port
  @@logger      = Logger.new(STDOUT)

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
    autoload :Delete, "paymill/operations/delete"
    autoload :Find,   "paymill/operations/find"
    autoload :Update, "paymill/operations/update"
  end

  module Request
    autoload :Base,       "paymill/request/base"
    autoload :Connection, "paymill/request/connection"
    autoload :Helpers,    "paymill/request/helpers"
    autoload :Info,       "paymill/request/info"
    autoload :Validator,  "paymill/request/validator"
  end

  class PaymillError < StandardError; end
  class AuthenticationError < PaymillError; end
  class APIError            < PaymillError; end

  # Returns the api key
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

  # Returns the api base endpoint
  #
  # @return [String] The api base endpoint
  def self.api_base
    @@api_base
  end

  # Sets the api base endpoint
  #
  # @param [String] api_base The api base endpoint
  def self.api_base=(api_base)
    @@api_base = api_base
  end

  # Returns the api version
  #
  # @return [String] The api version
  def self.api_version
    @@api_version
  end

  # Sets the api version
  #
  # @param [String] api_version The api version
  def self.api_version=(api_version)
    @@api_version = api_version
  end

  # Returns the api port
  #
  # @return [String] The api port
  def self.api_port
    @@api_port
  end

  # Sets the api port
  #
  # @param [String] api_port The api port
  def self.api_port=(api_port)
    @@api_port = api_port
  end

  # Returns the current logger
  #
  # @return [Logger] The current logger
  def self.logger
    @@logger
  end

  # Sets the logger for Paymill
  #
  # @param [Logger] logger The logger instance to be used
  def self.logger=(logger)
    @@logger = logger
  end

  # Makes a request against the Paymill API
  #
  # @param [Symbol] http_method The http method to use, must be one of :get, :post, :put and :delete
  # @param [String] api_url The API url to use
  # @param [Hash] data The data to send, e.g. used when creating new objects.
  # @return [Array] The parsed JSON response.
  def self.request(http_method, api_url, data)
    info = Request::Info.new(http_method, api_url, data)
    Request::Base.new(info).perform
  end
end
