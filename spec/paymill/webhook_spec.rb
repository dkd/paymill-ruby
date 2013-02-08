require "spec_helper"

describe Paymill::Webhook do
  let(:valid_attributes) do
    {
      url: "<your-webhook-url>",
      livemode:false,
      event_types:["transaction.succeeded","transaction.failed"]
    }
  end

  let (:webhook) do
    Paymill::Webhook.new(valid_attributes)
  end
  describe "#initialize" do
    it "initializes all attributes correctly" do
      webhook.url.should eql("<your-webhook-url>")
      webhook.livemode.should eql(false)
      webhook.event_types.should eql(["transaction.succeeded","transaction.failed"])   
    end
  end
  describe ".find" do
    it "makes a new GET request using the correct API endpoint to receive a specific webhook" do
      Paymill.should_receive(:request).with(:get, "webhooks/123", {}).and_return("data" => {})
      Paymill::Webhook.find("123")
    end
  end

  describe ".all" do
    it "makes a new GET request using the correct API endpoint to receive all webhooks" do
      Paymill.should_receive(:request).with(:get, "webhooks/", {}).and_return("data" => {})
      Paymill::Webhook.all
    end
  end

  describe ".create" do
    it "makes a new POST request using the correct API endpoint" do
      Paymill.should_receive(:request).with(:post, "webhooks", valid_attributes).and_return("data" => {})
      Paymill::Webhook.create(valid_attributes)
    end
  end
end