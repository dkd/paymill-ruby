require "spec_helper"

describe Paymill::Client do
  let(:valid_attributes) do
    { email: "stefan.sprenger@dkd.de", description: "First customer." }
  end

  let (:client) do
    Paymill::Client.new(valid_attributes)
  end

  describe "#initialize" do
    it "initializes all attributes correctly" do
      client.email.should eql("stefan.sprenger@dkd.de")
      client.description.should eql("First customer.")
    end
  end

  describe ".find" do
    it "makes a new GET request using the correct API endpoint" do
      Paymill.should_receive(:request).with(:get, "clients/123", {}).and_return("data" => {})
      Paymill::Client.find("123")
    end
  end

  describe ".delete" do
    it "makes a new DELETE request using the correct API endpoint" do
      Paymill.should_receive(:request).with(:delete, "clients/123", {}).and_return(true)
      Paymill::Client.delete("123")
    end
  end

  describe ".create" do
    it "makes a new POST request using the correct API endpoint" do
      Paymill.should_receive(:request).with(:post, "clients", valid_attributes).and_return("data" => {})
      Paymill::Client.create(valid_attributes)
    end
  end
end