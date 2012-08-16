require "net/http"
require "net/https"
require "json"
require "paymill/version"

module Paymill
  API_BASE = "api.paymill.de"

  @@api_key = nil

  autoload :Client,       "paymill/client"
  autoload :CreditCard,   "paymill/credit_card"
  autoload :Offer,        "paymill/offer"
  autoload :Subscription, "paymill/subscription"
  autoload :Transaction,  "paymill/transaction"

  module Operations
    autoload :Create, "paymill/operations/create"
    autoload :Find,   "paymill/operations/find"
  end

  class PaymillError < StandardError
  end

  class AuthenticationError < PaymillError; end
  class APIError            < PaymillError; end

  class << self
    def api_key
      @@api_key
    end

    def api_key=(api_key)
      @@api_key = api_key
    end

    def request(http_method, api_url, data, path="")
      raise AuthenticationError if api_key.nil?

      https              = Net::HTTP.new(API_BASE, Net::HTTP.https_default_port)
      https.use_ssl      = true
      https.verify_mode  = OpenSSL::SSL::VERIFY_PEER
      https.ca_file      = File.join(File.dirname(__FILE__), "data/paymill.crt")
      https.start do |connection|
        url = "/v1/#{api_url}#{path}"
        https_request = case http_method
              when :post
                Net::HTTP::Post.new(url)
              else
                Net::HTTP::Get.new(url)
              end
        https_request.basic_auth(api_key,"")
        https_request.set_form_data(data) if http_method == :post
        @response = https.request(https_request)
      end
      raise AuthenticationError if @response.code.to_i == 401
      raise APIError if @response.code.to_i >= 500

      data = JSON.parse(@response.body)
      raise APIError.new(data["error"]) if data["error"]

      data
    end
  end
end