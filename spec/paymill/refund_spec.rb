require 'spec_helper'

describe Paymill::Refund do
  let(:valid_attributes) do
    {
      amount: 4200,
      description: 'Test Refund'
    }
  end
  
  describe "Naming" do
    it "should return the correct collection_name" do
      Paymill::Refund.collection_name.must_equal 'refunds'
    end

    it "should return the correct api_path" do
      Paymill::Refund.api_path.must_equal 'refunds'
      Paymill::Refund.api_path(123).must_equal 'refunds/123'
    end
  end
  
  describe "create" do
    it "makes a new POST request using the correct API endpoint" do
      url = "https://api.paymill.com/v2/refunds/trans_123"
      stub_request(:post, url).to_return(:status => 200, :body => '{"data": {}}', :headers => {})
      Paymill::Refund.create('trans_123', valid_attributes)
      assert_requested :post, url
    end
  end
  
  describe "find" do
    it "makes a new GET request using the correct API endpoint to receive a specific refund" do
      url = "https://api.paymill.com/v2/refunds/123"
      stub_request(:get, url).to_return(:status => 200, :body => '{"data": {}}', :headers => {})
      Paymill::Refund.find("123")
      assert_requested :get, url
    end
  end
  
  describe "all" do
    it "makes a new GET request using the correct API endpoint to receive a all refunds" do
      url = "https://api.paymill.com/v2/refunds?order=created_at_desc"
      stub_request(:get, url).to_return(:status => 200, :body => '{"data": {}}', :headers => {})
      Paymill::Refund.order(:created_at, :desc).all
      assert_requested :get, url
    end
  end
end