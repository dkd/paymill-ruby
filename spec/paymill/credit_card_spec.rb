require "spec_helper"

describe Paymill::CreditCard do
  let(:valid_attributes) do
    {
      card_type:    "visa",
      country:      "germany",
      expire_month: 12,
      expire_year:  2012,
      card_holder:  "Stefan Sprenger",
      last4:        "1111"
    }
  end

  let (:credit_card) do
    Paymill::CreditCard.new(valid_attributes)
  end

  describe "#initialize" do
    it "initializes all attributes correctly" do
      credit_card.card_type.should eql("visa")
      credit_card.country.should eql("germany")
      credit_card.expire_month.should eql(12)
      credit_card.expire_year.should eq(2012)
      credit_card.card_holder.should eql("Stefan Sprenger")
      credit_card.last4.should eql("1111")
    end
  end

  describe ".find" do
    it "makes a new GET request using the correct API endpoint to receive a specific creditcard" do
      Paymill.should_receive(:request).with(:get, "creditcards/123", {}).and_return("data" => {})
      Paymill::CreditCard.find("123")
    end

    it "makes a new GET request using the correct API endpoint to receive all creditcards" do
      Paymill.should_receive(:request).with(:get, "creditcards/", {}).and_return("data" => {})
      Paymill::CreditCard.find()
    end
  end

  describe ".create" do
    it "makes a new POST request using the correct API endpoint" do
      Paymill.should_receive(:request).with(:post, "creditcards", valid_attributes).and_return("data" => {})
      Paymill::CreditCard.create(valid_attributes)
    end
  end
end