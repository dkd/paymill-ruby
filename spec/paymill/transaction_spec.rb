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
      client: "client_a013c",
      refunds: [
        {:id => "refund_abc"}
      ]
    }
  end

  let (:transaction) do
    Paymill::Transaction.new(valid_attributes)
  end

  describe "#initialize" do
    it "initializes all attributes correctly" do
      expect(transaction.amount).to eql(4200)
      expect(transaction.origin_amount).to eql(4200)
      expect(transaction.status).to eql("pending")
      expect(transaction.description).to eql("Test transaction.")
      expect(transaction.livemode).to eql(false)
      expect(transaction.response_code).to eql(20000)
      expect(transaction.payment[:card_type]).to eql("visa")
      expect(transaction.payment[:country]).to eql("germany")
      expect(transaction.client).to eql("client_a013c")
      expect(transaction.currency).to eql("EUR")
      expect(transaction.refunds).not_to be_nil
      expect(transaction.refunds).not_to be_empty
      expect(transaction.refunds.first).not_to be_nil
      expect(transaction.refunds.first[:id]).to eql("refund_abc")
    end
  end

  describe ".find" do
    it "makes a new GET request using the correct API endpoint to receive a specific transaction" do
      expect(Paymill).to receive(:request).with(:get, "transactions/123", {}).and_return("data" => {})
      Paymill::Transaction.find("123")
    end
  end

  describe ".all" do
    it "makes a new GET request using the correct API endpoint to receive all transactions" do
      expect(Paymill).to receive(:request).with(:get, "transactions/", {}).and_return("data" => {})
      Paymill::Transaction.all
    end
  end

  describe ".all with options" do
    it "makes a new GET request using the correct API endpoint to receive all transactions" do
      expect(Paymill).to receive(:request).with(:get, "transactions/", { client: "client_id" }).and_return("data" => {})
      Paymill::Transaction.all(client: "client_id")
    end
  end

  describe ".create" do
    it "makes a new POST request using the correct API endpoint" do
      expect(Paymill).to receive(:request).with(:post, "transactions", valid_attributes).and_return("data" => {})
      Paymill::Transaction.create(valid_attributes)
    end
  end

  describe "#update_attributes" do
    it "makes a new PUT request using the correct API endpoint" do
      transaction.id = "trans_123"
      expect(Paymill).to receive(:request).with(:put, "transactions/trans_123", {:description => "Transaction Description"}).and_return("data" => {})

      transaction.update_attributes({:description => "Transaction Description"})
    end

    it "updates the instance with the returned attributes" do
      changed_attributes = {:description => "Transaction Description"}
      expect(Paymill).to receive(:request).and_return("data" => changed_attributes)
      transaction.update_attributes(changed_attributes)

      expect(transaction.description).to eql("Transaction Description")
    end
  end
end
