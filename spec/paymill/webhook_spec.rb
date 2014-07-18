require "spec_helper"

describe Paymill::Webhook do
  let(:valid_attributes) do
    {
      url: "<your-webhook-url>",
      livemode:false,
      event_types:["transaction.succeeded","transaction.failed"],
      created_at:1360368749,
      updated_at:1360368749
    }
  end

  let (:webhook) do
    Paymill::Webhook.new(valid_attributes)
  end

  describe "#initialize" do
    it "initializes all attributes correctly" do
      expect(webhook.url).to eql("<your-webhook-url>")
      expect(webhook.livemode).to eql(false)
      expect(webhook.event_types).to eql(["transaction.succeeded","transaction.failed"])   
      expect(webhook.created_at.to_i).to eql(1360368749)
      expect(webhook.updated_at.to_i).to eql(1360368749)
    end
  end

  describe ".find" do
    it "makes a new GET request using the correct API endpoint to receive a specific webhook" do
      expect(Paymill).to receive(:request).with(:get, "webhooks/123", {}).and_return("data" => {})
      Paymill::Webhook.find("123")
    end
  end

  describe ".all" do
    it "makes a new GET request using the correct API endpoint to receive all webhooks" do
      expect(Paymill).to receive(:request).with(:get, "webhooks/", {}).and_return("data" => {})
      Paymill::Webhook.all
    end
  end

  describe ".create" do
    it "makes a new POST request using the correct API endpoint" do
      expect(Paymill).to receive(:request).with(:post, "webhooks", valid_attributes).and_return("data" => {})
      Paymill::Webhook.create(valid_attributes)
    end
  end

  describe ".delete" do
    it "makes a new DELETE request using the correct API endpoint" do
      expect(Paymill).to receive(:request).with(:delete, "webhooks/123", {}).and_return(true)
      Paymill::Webhook.delete("123")
    end
  end

  describe "#update_attributes" do
    it "makes a new PUT request using the correct API endpoint" do
      changed_attributes = {:url => "<new-webhook-url>"}
      webhook.id    = "hook_123"
      expect(Paymill).to receive(:request).with(:put, "webhooks/hook_123", changed_attributes).and_return("data" => changed_attributes)
      webhook.update_attributes(changed_attributes)
    end

    it "should set the returned attributes on the instance" do
      expect(Paymill).to receive(:request).and_return("data" => {:url => "<new-webhook-url>"})
      webhook.update_attributes({})
      expect(webhook.url).to eql("<new-webhook-url>")
    end
  end
end
