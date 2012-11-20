require 'spec_helper'

describe Paymill::Preauthorization do
  let(:valid_attributes) do
    {
      token: "098f6bcd4621d373cade4e832627b4f6",
      amount: 4200,
      currency: "EUR"
    }
  end
  
  describe "Naming" do
    it "should return the correct collection_name" do
      Paymill::Preauthorization.collection_name.must_equal 'preauthorizations'
    end

    it "should return the correct api_path" do
      Paymill::Preauthorization.api_path.must_equal 'preauthorizations'
      Paymill::Preauthorization.api_path(123).must_equal 'preauthorizations/123'
    end
  end
  
  describe "create" do
    it "makes a new POST request using the correct API endpoint" do
      url = "https://api.paymill.de/v2/preauthorizations"
      stub_request(:post, url).to_return(:status => 200, :body => '{"data": {}}', :headers => {})
      Paymill::Preauthorization.create(valid_attributes)
      assert_requested :post, url
    end
  end
  
  describe "find" do
    it "makes a new GET request using the correct API endpoint to receive a specific preauthorization" do
      url = "https://api.paymill.de/v2/preauthorizations/123"
      stub_request(:get, url).to_return(:status => 200, :body => '{"data": {}}', :headers => {})
      Paymill::Preauthorization.find("123")
      assert_requested :get, url
    end
  end
  
  describe "all" do
    it "makes a new GET request using the correct API endpoint to receive all preauthorizations" do
      url = "https://api.paymill.de/v2/preauthorizations?order=created_at_desc"
      stub_request(:get, url).to_return(:status => 200, :body => '{"data": {}}', :headers => {})
      Paymill::Preauthorization.order(:created_at, :desc).all
      assert_requested :get, url
    end
  end
end