require "spec_helper"

describe Paymill::Payment do
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

  let (:payment) do
    Paymill::Payment.new(valid_attributes)
  end

  describe "#initialize" do
    it "initializes all attributes correctly" do
      payment.card_type.should eql("visa")
      payment.country.should eql("germany")
      payment.expire_month.should eql(12)
      payment.expire_year.should eq(2012)
      payment.card_holder.should eql("Stefan Sprenger")
      payment.last4.should eql("1111")
    end
  end

  describe ".find" do
    it "makes a new GET request using the correct API endpoint to receive a specific creditcard" do
      Paymill.should_receive(:request).with(:get, "payments/123", {}).and_return("data" => {})
      Paymill::Payment.find("123")
    end
  end

  describe ".all" do
    it "makes a new GET request using the correct API endpoint to receive all payments" do
      Paymill.should_receive(:request).with(:get, "payments/", {}).and_return("data" => {})
      Paymill::Payment.all
    end
  end

  describe ".create" do
    it "makes a new POST request using the correct API endpoint" do
      Paymill.should_receive(:request).with(:post, "payments", valid_attributes).and_return("data" => {})
      Paymill::Payment.create(valid_attributes)
    end
  end

  describe ".delete" do
    it "makes a new DELETE request using the correct API endpoint" do
      Paymill.should_receive(:request).with(:delete, "payments/123", {}).and_return(true)
      Paymill::Payment.delete("123")
    end
  end
end
