require "spec_helper"

describe Paymill::Transaction do
  let(:valid_attributes) do
    {
      amount: 4200,
      status: "pending",
      description: "Test transaction.",
      livemode: false,
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

  describe "initialize" do
    it "initializes all attributes correctly" do
      transaction.amount.must_equal(4200)
      transaction.status.must_equal("pending")
      transaction.description.must_equal("Test transaction.")
      transaction.livemode.must_equal(false)
      transaction.payment[:card_type].must_equal("visa")
      transaction.payment[:country].must_equal("germany")
      transaction.client.must_equal("client_a013c")
    end
  end
  
  describe "Naming" do
    it "should return the correct collection_name" do
      Paymill::Transaction.collection_name.must_equal 'transactions'
    end

    it "should return the correct api_path" do
      Paymill::Transaction.api_path.must_equal 'transactions'
      Paymill::Transaction.api_path(123).must_equal 'transactions/123'
    end
  end

  describe "find" do
    it "makes a new GET request using the correct API endpoint to receive a specific transaction" do
      skip
      Paymill.should_receive(:request).with(:get, "transactions/123", {}).and_return("data" => {})
      Paymill::Transaction.find("123")
    end
  end

  describe ".all" do
    it "makes a new GET request using the correct API endpoint to receive all transactions" do
      skip
      Paymill.should_receive(:request).with(:get, "transactions", {}).and_return("data" => {})
      Paymill::Transaction.all
    end
  end

  describe ".create" do
    it "makes a new POST request using the correct API endpoint" do
      skip
      Paymill.should_receive(:request).with(:post, "transactions", valid_attributes).and_return("data" => {})
      Paymill::Transaction.create(valid_attributes)
    end
  end
end
