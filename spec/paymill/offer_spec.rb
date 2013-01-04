require "spec_helper"

describe Paymill::Offer do
  let(:valid_attributes) do
    {
      amount:   4200,
      currency: "eur",
      interval: "month",
      name:     "Medium Plan"
    }
  end

  let (:offer) do
    Paymill::Offer.new(valid_attributes)
  end

  describe "#initialize" do
    it "initializes all attributes correctly" do
      offer.amount.should eql(4200)
      offer.currency.should eql("eur")
      offer.interval.should eql("month")
      offer.name.should eql("Medium Plan")
    end
  end

  describe ".find" do
    it "makes a new GET request using the correct API endpoint to receive a specific offer" do
      Paymill.should_receive(:request).with(:get, "offers/123", {}).and_return("data" => {})
      Paymill::Offer.find("123")
    end
  end

  describe ".all" do
    it "makes a new GET request using the correct API endpoint to receive all offers" do
      Paymill.should_receive(:request).with(:get, "offers/", {}).and_return("data" => {})
      Paymill::Offer.all
    end
  end

  describe ".delete" do
    it "makes a new DELETE request using the correct API endpoint" do
      Paymill.should_receive(:request).with(:delete, "offers/123", {}).and_return(true)
      Paymill::Offer.delete("123")
    end
  end

  describe ".create" do
    it "makes a new POST request using the correct API endpoint" do
      Paymill.should_receive(:request).with(:post, "offers", valid_attributes).and_return("data" => {})
      Paymill::Offer.create(valid_attributes)
    end
  end

  describe "#update_attributes" do
    it "makes a new PUT request using the correct API endpoint" do
      offer.id = "offer_123"
      Paymill.should_receive(:request).with(:put, "offers/offer_123", {:name => "Large Plan"}).and_return("data" => {})

      offer.update_attributes({:name => "Large Plan"})
    end

    it "updates the instance with the returned attributes" do
      changed_attributes = {:name => "Large Plan"}
      Paymill.should_receive(:request).and_return("data" => changed_attributes)
      offer.update_attributes(changed_attributes)

      offer.name.should eql("Large Plan")
    end
  end
end
