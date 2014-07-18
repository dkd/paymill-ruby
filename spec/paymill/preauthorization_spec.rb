require "spec_helper"

describe Paymill::Preauthorization do
  let(:valid_attributes) do
    { 
      payment: "pay_d43cf0ee969d9847512b", 
      amount: 4200,
      currency: "EUR" 
    }
  end

  let (:preauthorization) do
    Paymill::Preauthorization.new(valid_attributes)
  end

  describe "#initialize" do
    it "initializes all attributes correctly" do
      expect(preauthorization.payment).to eql("pay_d43cf0ee969d9847512b")
      expect(preauthorization.amount).to eql(4200)
      expect(preauthorization.currency).to eql("EUR")
    end
  end

  describe ".create" do
    it "makes a new POST request using the correct API endpoint" do
      expect(Paymill).to receive(:request).with(:post, "preauthorizations", valid_attributes).and_return("data" => {})
      Paymill::Preauthorization.create(valid_attributes)
    end
  end

  describe ".delete" do
    it "makes a new DELETE request using the correct API endpoint" do
      expect(Paymill).to receive(:request).with(:delete, "preauthorizations/123", {}).and_return(true)
      Paymill::Preauthorization.delete("123")
    end
  end
end
