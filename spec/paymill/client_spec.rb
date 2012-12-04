require "spec_helper"

describe Paymill::Client do
  let(:valid_attributes) do
    { email: "stefan.sprenger@dkd.de", description: "First customer." }
  end
    
  let (:client) do
    Paymill::Client.new(valid_attributes)
  end
    
    
  describe "initialize" do
    it "initializes all attributes correctly" do
      client.email.must_equal "stefan.sprenger@dkd.de"
      client.description.must_equal "First customer."
    end
  end
  
  describe "Naming" do
    it "should return the correct collection_name" do
      Paymill::Client.collection_name.must_equal 'clients'
    end

    it "should return the correct api_path" do
      Paymill::Client.api_path.must_equal 'clients'
      Paymill::Client.api_path(123).must_equal 'clients/123'
    end
  end  
    
    
  describe "find" do
    it "makes a new GET request using the correct API endpoint to receive a specific client" do
      url = "https://api.paymill.com/v2/clients/123"
      stub_request(:get, url).to_return(:status => 200, :body => '{"data": {}}', :headers => {})
      Paymill::Client.find("123")
      assert_requested :get, url
    end
  end
    
  describe "all" do
    it "makes a new GET request using the correct API endpoint to receive all clients" do
      url = "https://api.paymill.com/v2/clients?order=created_at_asc"
      stub_request(:get, url).to_return(:status => 200, :body => '{"data": []}', :headers => {})
      Paymill::Client.all
      assert_requested :get, url
    end
  end
    
  describe "delete" do
    it "makes a new DELETE request using the correct API endpoint" do
      url = "https://api.paymill.com/v2/clients/123"
      stub_request(:delete, url).to_return(:status => 200, :body => '{"data": []}', :headers => {})
      Paymill::Client.delete("123")
      assert_requested :delete, url
    end
  end
    
  describe "create" do
    it "makes a new POST request using the correct API endpoint" do
      url = "https://api.paymill.com/v2/clients"
      stub_request(:post, url).to_return(:status => 200, :body => '{"data": {}}', :headers => {})
      Paymill::Client.create(valid_attributes)
      assert_requested :post, url
    end
  end
  
  describe "update" do
    it "makes a new PUT request using the correct API endpoint" do
      url = "https://api.paymill.com/v2/clients/123"
      stub_request(:put, url).to_return(:status => 200, :body => '{"data": {}}', :headers => {})
      Paymill::Client.update(123, valid_attributes)
      assert_requested :put, url
    end
  end
end