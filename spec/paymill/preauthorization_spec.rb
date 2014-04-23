require "spec_helper"

describe Paymill::Preauthorization do
  let(:valid_attributes) do
    { 
      payment: "pay_d43cf0ee969d9847512b", 
      amount: 4200,
      currency: "EUR",
      response_code: 20000 
    }
  end

  let (:preauthorization) do
    Paymill::Preauthorization.new(valid_attributes)
  end

  describe "#initialize" do
    it "initializes all attributes correctly" do
      preauthorization.payment.should eql("pay_d43cf0ee969d9847512b")
      preauthorization.amount.should eql(4200)
      preauthorization.currency.should eql("EUR")
      preauthorization.response_code.should eql(20000)
    end
  end

  describe ".create" do
    it "makes a new POST request using the correct API endpoint" do
      Paymill.should_receive(:request).with(:post, "preauthorizations", valid_attributes).and_return("data" => {})
      Paymill::Preauthorization.create(valid_attributes)
    end
  end

  describe ".delete" do
    it "makes a new DELETE request using the correct API endpoint" do
      Paymill.should_receive(:request).with(:delete, "preauthorizations/123", {}).and_return(true)
      Paymill::Preauthorization.delete("123")
    end
  end
end
