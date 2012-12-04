require "spec_helper"

describe Paymill do
  describe "user_agent" do
    it "should return the paymill user agent" do
      Paymill.user_agent.must_match /paymill\-ruby/
    end
  end
  
  describe "uri" do
    it "should return an proper URI" do
      Paymill.uri.must_be_instance_of URI::HTTPS
      Paymill.uri.scheme.must_equal 'https'
      Paymill.uri.host.must_equal 'api.paymill.com'
      Paymill.uri.path.must_match /^\/v2\//
    end
  end

  describe "configure" do
    it "should be configurable with a block" do
      Paymill.configure do |c|
        c.api_key = '123'
        c.timeout = 5
      end
      Paymill.api_key.must_equal '123'
      Paymill.timeout.must_equal 5
    end
  end
  
  # describe "currency" do
  #   it "defaults to Money.default_currency" do
  #     Paymill.currency.must_be_kind_of Money::Currency
  #   end
  #   
  #   it "can assign a new currency as symbol" do
  #     Paymill.currency = :eur
  #     Paymill.currency.must_equal Money::Currency.new(:eur)
  #   end
  #   
  #   it "can assign a new currency as string" do
  #     Paymill.currency = 'SEK'
  #     Paymill.currency.must_equal Money::Currency.new(:sek)
  #   end
  #   
  #   it "can assign a new currency as Money::Currency" do
  #     Paymill.currency = Money::Currency.new(:dkk)
  #     Paymill.currency.must_equal Money::Currency.new(:dkk)
  #   end
  # end
  
  # describe ".request" do
  #   context "given no api key exists" do
  #     it "raises an authentication error" do
  #       expect { Paymill.request(:get, "clients", {}) }.to raise_error(Paymill::AuthenticationError)
  #     end
  #   end
  # end
end