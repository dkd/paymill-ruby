require "spec_helper"

describe Paymill::Subscription do
  let(:valid_attributes) do
    {
      offer:                {
        name:     "Nerd special",
        amount:   123,
        interval: "week"
      },
      livemode:             false,
      next_capture_at:      1349945681,
      trial_start:          1349945681,
      trial_end:            1349945682,
      cancel_at_period_end: false,
      client:               {
        email: "stefan.sprenger@dkd.de"
      },
      payment:              {
        id: "pay_3af44644dd6d25c820a8",
      }
    }
  end

  let (:subscription) do
    Paymill::Subscription.new(valid_attributes)
  end

  describe "#initialize" do
    it "initializes all attributes correctly" do
      expect(subscription.offer[:name]).to eql("Nerd special")
      expect(subscription.offer[:amount]).to eql(123)
      expect(subscription.offer[:interval]).to eql("week")
      expect(subscription.livemode).to be false
      expect(subscription.cancel_at_period_end).to be false
      expect(subscription.client[:email]).to eql("stefan.sprenger@dkd.de")
      expect(subscription.payment[:id]).to eql("pay_3af44644dd6d25c820a8")
      expect(subscription.trial_start.to_i).to eql(1349945681)
      expect(subscription.trial_end.to_i).to eql(1349945682)
    end
  end

  describe "#parse_timestamps" do
    context "given #canceled_at is present" do
      it "creates a Time object" do
        subscription = Paymill::Subscription.new(canceled_at: 1362823928)
        expect(subscription.canceled_at.class).to eql(Time)
      end
    end

    context "given #trial_start is present" do
      it "creates a Time object" do
        subscription = Paymill::Subscription.new(trial_start: 1362823928)
        expect(subscription.trial_start.class).to eql(Time)
      end
    end

    context "given #trial_end is present" do
      it "creates a Time object" do
        subscription = Paymill::Subscription.new(trial_end: 1362823928)
        expect(subscription.trial_end.class).to eql(Time)
      end
    end

    context "given #next_capture_at is present" do
      it "creates a Time object" do
        subscription = Paymill::Subscription.new(next_capture_at: 1362823928)
        expect(subscription.next_capture_at.class).to eql(Time)
      end
    end
  end

  describe ".find" do
    it "makes a new GET request using the correct API endpoint to receive a specific subscription" do
      expect(Paymill).to receive(:request).with(:get, "subscriptions/123", {}).and_return("data" => {})
      Paymill::Subscription.find("123")
    end
  end

  describe ".all" do
    it "makes a new GET request using the correct API endpoint to receive all subscriptions" do
      expect(Paymill).to receive(:request).with(:get, "subscriptions/", {}).and_return("data" => {})
      Paymill::Subscription.all
    end
  end

  describe ".delete" do
    it "makes a new DELETE request using the correct API endpoint" do
      expect(Paymill).to receive(:request).with(:delete, "subscriptions/123", {}).and_return(true)
      Paymill::Subscription.delete("123")
    end
  end

  describe ".create" do
    it "makes a new POST request using the correct API endpoint" do
      expect(Paymill).to receive(:request).with(:post, "subscriptions", valid_attributes).and_return("data" => {})
      Paymill::Subscription.create(valid_attributes)
    end
  end

  describe ".update_attributes" do
    it "makes a new PUT request using the correct API endpoint" do
      expect(Paymill).to receive(:request).with(:put, "subscriptions/sub_123", {:offer => 50 }).and_return("data" => {})
      Paymill::Subscription.update_attributes("sub_123", {:offer => 50 })
    end
  end

  describe "#update_attributes" do
    it "makes a new PUT request using the correct API endpoint" do
      changed_attributes = {:cancel_at_period_end => true}
      subscription.id    = "sub_123"

      expect(Paymill).to receive(:request).with(:put, "subscriptions/sub_123", changed_attributes).and_return("data" => changed_attributes)

      subscription.update_attributes(changed_attributes)
    end

    it "should set the returned attributes on the instance" do
      expect(Paymill).to receive(:request).and_return("data" => {:cancel_at_period_end => true})
      subscription.update_attributes({})
      expect(subscription.cancel_at_period_end).to be true
    end
  end
end
