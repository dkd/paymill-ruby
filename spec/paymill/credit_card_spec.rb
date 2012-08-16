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
end