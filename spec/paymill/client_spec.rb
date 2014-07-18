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
      expect(client.email).to eql("stefan.sprenger@dkd.de")
      expect(client.description).to eql("First customer.")
    end
  end

  describe ".find" do
    it "makes a new GET request using the correct API endpoint to receive a specific client" do
      expect(Paymill).to receive(:request).with(:get, "clients/123", {}).and_return("data" => {})
      Paymill::Client.find("123")
    end
  end

  describe ".all" do
    it "makes a new GET request using the correct API endpoint to receive all clients" do
      expect(Paymill).to receive(:request).with(:get, "clients/", {}).and_return("data" => {})
      Paymill::Client.all
    end
  end

  describe ".delete" do
    it "makes a new DELETE request using the correct API endpoint" do
      expect(Paymill).to receive(:request).with(:delete, "clients/123", {}).and_return(true)
      Paymill::Client.delete("123")
    end
  end

  describe ".create" do
    it "makes a new POST request using the correct API endpoint" do
      expect(Paymill).to receive(:request).with(:post, "clients", valid_attributes).and_return("data" => {})
      Paymill::Client.create(valid_attributes)
    end
  end

  describe "#update_attributes" do
    it "makes a new PUT request using the correct API endpoint" do
      client.id = "client_123"
      expect(Paymill).to receive(:request).with(:put, "clients/client_123", {:email => "tim.test@exmaple.com"}).and_return("data" => {})

      client.update_attributes({:email => "tim.test@exmaple.com"})
    end

    it "updates the instance with the returned attributes" do
      changed_attributes = {:email => "tim.test@example.com"}
      expect(Paymill).to receive(:request).and_return("data" => changed_attributes)
      client.update_attributes(changed_attributes)

      expect(client.email).to eql("tim.test@example.com")
    end
  end
end
