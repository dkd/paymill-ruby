require "spec_helper"

describe Paymill::Transaction do
  let(:valid_attributes) do
    {
      amount: 4200,
      origin_amount: 4200,
      currency: "EUR",
      status: "pending",
      description: "Test transaction.",
      livemode: false,
      response_code: 20000,
      payment: {
        card_type: "visa",
        country: "germany"
      },
      client: "client_a013c"
    }
  end

  let (:transaction) do
    Paymill::Transaction.new(valid_attributes)
  end

  describe "#initialize" do
    it "initializes all attributes correctly" do
      transaction.amount.should eql(4200)
      transaction.origin_amount.should eql(4200)
      transaction.status.should eql("pending")
      transaction.description.should eql("Test transaction.")
      transaction.livemode.should eql(false)
      transaction.response_code.should eql(20000)
      transaction.payment[:card_type].should eql("visa")
      transaction.payment[:country].should eql("germany")
      transaction.client.should eql("client_a013c")
      transaction.currency.should eql("EUR")
    end
  end

  describe ".find" do
    it "makes a new GET request using the correct API endpoint to receive a specific transaction" do
      Paymill.should_receive(:request).with(:get, "transactions/123", {}).and_return("data" => {})
      Paymill::Transaction.find("123")
    end
  end

  describe ".all" do
    it "makes a new GET request using the correct API endpoint to receive all transactions" do
      Paymill.should_receive(:request).with(:get, "transactions/", {}).and_return("data" => {})
      Paymill::Transaction.all
    end
  end

  describe ".all with options" do
    it "makes a new GET request using the correct API endpoint to receive all transactions" do
      Paymill.should_receive(:request).with(:get, "transactions/", { client: "client_id" }).and_return("data" => {})
      Paymill::Transaction.all(client: "client_id")
    end
  end

  describe ".create" do
    it "makes a new POST request using the correct API endpoint" do
      Paymill.should_receive(:request).with(:post, "transactions", valid_attributes).and_return("data" => {})
      Paymill::Transaction.create(valid_attributes)
    end
  end
end
