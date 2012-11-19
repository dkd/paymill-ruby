require "spec_helper"

describe Paymill::Subscription do
  let(:valid_attributes) do
    {
      offer: {
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

  describe "initialize" do
    it "initializes all attributes correctly" do
      subscription.offer[:name].must_equal("Nerd special")
      subscription.offer[:amount].must_equal(123)
      subscription.offer[:interval].must_equal("week")
      subscription.livemode.must_equal false
      subscription.cancel_at_period_end.must_equal false
      subscription.client[:email].must_equal("stefan.sprenger@dkd.de")
    end
  end
  
  describe "Naming" do
    it "should return the correct collection_name" do
      Paymill::Subscription.collection_name.must_equal 'subscriptions'
    end

    it "should return the correct api_path" do
      Paymill::Subscription.api_path.must_equal 'subscriptions'
      Paymill::Subscription.api_path(123).must_equal 'subscriptions/123'
    end
  end

  describe "find" do
    it "makes a new GET request using the correct API endpoint to receive a specific subscription" do
skip
      Paymill.should_receive(:request).with(:get, "subscriptions/123", {}).and_return("data" => {})
      Paymill::Subscription.find("123")
    end
  end

  describe "all" do
    it "makes a new GET request using the correct API endpoint to receive all subscriptions" do
skip
      Paymill.should_receive(:request).with(:get, "subscriptions", {}).and_return("data" => {})
      Paymill::Subscription.all
    end
  end

  describe "delete" do
    it "makes a new DELETE request using the correct API endpoint" do
skip
      Paymill.should_receive(:request).with(:delete, "subscriptions/123", {}).and_return(true)
      Paymill::Subscription.delete("123")
    end
  end

  describe "create" do
    it "makes a new POST request using the correct API endpoint" do
skip
      Paymill.should_receive(:request).with(:post, "subscriptions", valid_attributes).and_return("data" => {})
      Paymill::Subscription.create(valid_attributes)
    end
  end
end
