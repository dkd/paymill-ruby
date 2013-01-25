require "net/http"
require "net/https"
require "json"
require "paymill/version"

module Paymill
  API_BASE    = "api.paymill.de"
  API_VERSION = "v2"

  @@api_key = nil

  autoload :Base,             "paymill/base"
  autoload :Client,           "paymill/client"
  autoload :Offer,            "paymill/offer"
  autoload :Payment,          "paymill/payment"
  autoload :Preauthorization, "paymill/preauthorization"
  autoload :Subscription,     "paymill/subscription"
  autoload :Transaction,      "paymill/transaction"

  module Operations
    autoload :All,    "paymill/operations/all"
    autoload :Create, "paymill/operations/create"
    autoload :Find,   "paymill/operations/find"
    autoload :Update, "paymill/operations/update"
    autoload :Delete, "paymill/operations/delete"
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

    def request(http_method, api_url, data)
      raise AuthenticationError if api_key.nil?

      https             = Net::HTTP.new(API_BASE, Net::HTTP.https_default_port)
      https.use_ssl     = true
      https.verify_mode = OpenSSL::SSL::VERIFY_PEER
      https.ca_file     = File.join(File.dirname(__FILE__), "data/paymill.crt")
      https.start do |connection|
        url = "/#{API_VERSION}/#{api_url}"
        https_request = case http_method
              when :post
                Net::HTTP::Post.new(url)
              when :put
                Net::HTTP::Put.new(url)
              when :delete
                Net::HTTP::Delete.new(url)
              else
                Net::HTTP::Get.new(url)
              end
        https_request.basic_auth(api_key, "")
        https_request.set_form_data(data) if [:post, :put].include? http_method
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
