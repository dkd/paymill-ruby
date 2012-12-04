# -*- encoding: utf-8 -*-
require "spec_helper"

describe Paymill::DirectDebit do
  let(:valid_attributes) do
    {
      id: "pay_917018675b21ca03c4fb",
      type: "debit",
      client: nil,
      code: "860555000",
      holder: "Tobias Fuenke",
      account: "******2345",
      created_at: 1349944973,
      updated_at: 1349944973
    }
  end
 
  let (:payment) do
    Paymill::DirectDebit.new(valid_attributes)
  end

  describe "initialize" do
    it "initializes all attributes correctly" do
      payment.code.must_equal "860555000"
      payment.holder.must_equal "Tobias Fuenke"
      payment.account.must_equal "******2345"
    end
  end

  describe "number" do
    it "should return a formatted number" do
      payment.number.must_equal "•••• •••• •••• 2345"
    end
    
    it "should return a formatted number with custom settings" do
      payment.number(mask: '*', separator: ':').must_equal '****:****:****:2345'
    end
    
    it "should return this last 4 digits" do
      payment.last4.must_equal "2345"
    end
  end
  
  describe "holder" do
    it "should return the holders name" do
      payment.holder.must_equal "Tobias Fuenke"
    end
  end
  
  describe "collection_name" do
    it "should have the correct collection name" do
      payment.class.collection_name.must_equal 'payments'
    end
    
    it "should get the correct api path from collection name" do
      payment.class.api_path.must_equal 'payments'
      payment.class.api_path(1, "test").must_equal 'payments/1/test'
    end
  end
  
  describe "build" do
    it "should initialize the correct class" do
      Paymill::Payment.build(valid_attributes.merge(type: 'debit')).must_be_instance_of Paymill::DirectDebit
      Paymill::Payment.build(valid_attributes.merge(type: 'creditcard')).must_be_instance_of Paymill::CreditCard
    end
  end

  describe "find" do
    it "makes a new GET request using the correct API endpoint to receive a specific creditcard" do
      url = "https://api.paymill.com/v2/payments/123"
      stub_request(:get, url).to_return(:status => 200, :body => '{"data": {}}', :headers => {})
      Paymill::DirectDebit.find("123")
      assert_requested :get, url
    end
  end

  describe "all" do
    it "makes a new GET request using the correct API endpoint to receive all creditcards" do
      url = "https://api.paymill.com/v2/payments?order=created_at_asc"
      stub_request(:get, url).to_return(:status => 200, :body => '{"data": {}}', :headers => {})
      Paymill::DirectDebit.all
      assert_requested :get, url
    end
  end
  
  describe "create" do
    it "makes a new POST request using the correct API endpoint" do
      url = "https://api.paymill.com/v2/payments"
      stub_request(:post, url).to_return(:status => 200, :body => '{"data": {}}', :headers => {})
      Paymill::DirectDebit.create(valid_attributes)
      assert_requested :post, url
    end
  end
end
