require "spec_helper"

describe Paymill::Subscription do
  let(:valid_attributes) do
    {
      plan: {
        name:     "Nerd special",
        amount:   123,
        interval: "week"
      },
      livemode: false,
      cancel_at_period_end: false,
      client: {
        email: "stefan.sprenger@dkd.de"
      }
    }
  end

  let (:subscription) do
    Paymill::Subscription.new(valid_attributes)
  end

  describe "#initialize" do
    it "initializes all attributes correctly" do
      subscription.plan[:name].should eql("Nerd special")
      subscription.plan[:amount].should eql(123)
      subscription.plan[:interval].should eql("week")
      subscription.livemode.should be_false
      subscription.cancel_at_period_end.should be_false
      subscription.client[:email].should eql("stefan.sprenger@dkd.de")
    end
  end

  describe ".find" do
    it "makes a new GET request using the correct API endpoint to receive a specific subscription" do
      Paymill.should_receive(:request).with(:get, "subscriptions/123", {}).and_return("data" => {})
      Paymill::Subscription.find("123")
    end
  end

  describe ".all" do
    it "makes a new GET request using the correct API endpoint to receive all subscriptions" do
      Paymill.should_receive(:request).with(:get, "subscriptions/", {}).and_return("data" => {})
      Paymill::Subscription.all()
    end
  end

  describe ".delete" do
    it "makes a new DELETE request using the correct API endpoint" do
      Paymill.should_receive(:request).with(:delete, "subscriptions/123", {}).and_return(true)
      Paymill::Subscription.delete("123")
    end
  end

  describe ".create" do
    it "makes a new POST request using the correct API endpoint" do
      Paymill.should_receive(:request).with(:post, "subscriptions", valid_attributes).and_return("data" => {})
      Paymill::Subscription.create(valid_attributes)
    end
  end
end