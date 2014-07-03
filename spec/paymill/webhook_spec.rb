require "spec_helper"

describe Paymill::Webhook do
  let(:valid_attributes) do
    {
      id: "hook_40237e20a7d5a231d99b",
      url: "<your-webhook-url>",
      livemode: false,
      event_types: ["transaction.succeeded","transaction.failed"],
      created_at: 1360368749,
      updated_at: 1360368749,
      active: true,
      app_id: nil
    }
  end

  let (:webhook) do
    Paymill::Webhook.new(valid_attributes)
  end

  describe "#initialize" do
    it "initializes all attributes correctly" do
      webhook.id.should eql("hook_40237e20a7d5a231d99b")
      webhook.url.should eql("<your-webhook-url>")
      webhook.livemode.should eql(false)
      webhook.event_types.should eql(["transaction.succeeded","transaction.failed"])   
      webhook.created_at.to_i.should eql(1360368749)
      webhook.updated_at.to_i.should eql(1360368749)
      webhook.active.should be_true
      webhook.app_id.should be_nil
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

  describe ".delete" do
    it "makes a new DELETE request using the correct API endpoint" do
      Paymill.should_receive(:request).with(:delete, "webhooks/123", {}).and_return(true)
      Paymill::Webhook.delete("123")
    end
  end

  describe "#update_attributes" do
    it "makes a new PUT request using the correct API endpoint" do
      changed_attributes = {:url => "<new-webhook-url>"}
      webhook.id    = "hook_123"
      Paymill.should_receive(:request).with(:put, "webhooks/hook_123", changed_attributes).and_return("data" => changed_attributes)
      webhook.update_attributes(changed_attributes)
    end

    it "should set the returned attributes on the instance" do
      Paymill.should_receive(:request).and_return("data" => {:url => "<new-webhook-url>"})
      webhook.update_attributes({})
      webhook.url.should eql("<new-webhook-url>")
    end
  end
end
