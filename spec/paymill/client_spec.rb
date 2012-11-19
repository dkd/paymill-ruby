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
    
    
  describe ".find" do
    it "makes a new GET request using the correct API endpoint to receive a specific client" do
skip
      Paymill.should_receive(:request).with(:get, "clients/123", {}).and_return("data" => {})
      Paymill::Client.find("123")
    end
  end
    
  describe ".all" do
    it "makes a new GET request using the correct API endpoint to receive all clients" do
skip
      Paymill.should_receive(:request).with(:get, "clients", {}).and_return("data" => {})
      Paymill::Client.all
    end
  end
    
  describe ".delete" do
    it "makes a new DELETE request using the correct API endpoint" do
skip
      Paymill.should_receive(:request).with(:delete, "clients/123", {}).and_return(true)
      Paymill::Client.delete("123")
    end
  end
    
  describe ".create" do
    it "makes a new POST request using the correct API endpoint" do
skip
      Paymill.should_receive(:request).with(:post, "clients", valid_attributes).and_return("data" => {})
      Paymill::Client.create(valid_attributes)
    end
  end
end