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
      payment.number.must_equal "••••-••••-••••-2345"
    end
    
    it "should return a formatted number with custom settings" do
      payment.number(placeholder: '*', separator: ':').must_equal '****:****:****:2345'
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
  
  describe "new_from_response" do
    it "should initialize the correct class" do
      Paymill::Payment.build(valid_attributes.merge(type: 'debit')).must_be_instance_of Paymill::DirectDebit
      Paymill::Payment.build(valid_attributes.merge(type: 'creditcard')).must_be_instance_of Paymill::CreditCard
    end
  end

  describe "find" do
    it "makes a new GET request using the correct API endpoint to receive a specific creditcard" do
    end
  end


  # describe "find" do
  #   it "makes a new GET request using the correct API endpoint to receive a specific creditcard" do
  #     skip
  #     Paymill.should_receive(:request).with(:get, "creditcards/123", {}).and_return("data" => {})
  #     Paymill::CreditCard.find("123")
  #   end
  # end
  # 
  # describe "all" do
  #   it "makes a new GET request using the correct API endpoint to receive all creditcards" do
  #     skip
  #     Paymill.should_receive(:request).with(:get, "creditcards", {}).and_return("data" => {})
  #     Paymill::CreditCard.all
  #   end
  # end
  # 
  # describe "create" do
  #   it "makes a new POST request using the correct API endpoint" do
  #     skip
  #     Paymill.should_receive(:request).with(:post, "creditcards", valid_attributes).and_return("data" => {})
  #     Paymill::CreditCard.create(valid_attributes)
  #   end
  # end
end
