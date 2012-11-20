require "spec_helper"

describe Paymill::Transaction do
  let(:valid_attributes) do
    {
      amount: 4200,
      status: "partial_refunded",
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
      transaction.status.must_equal("partial_refunded")
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
      url = "https://api.paymill.de/v2/transactions/123"
      stub_request(:get, url).to_return(:status => 200, :body => '{"data": {}}', :headers => {})
      Paymill::Transaction.find("123")
      assert_requested :get, url
    end
  end

  describe "all" do
    it "makes a new GET request using the correct API endpoint to receive all transactions" do
      url = "https://api.paymill.de/v2/transactions?order=created_at_asc"
      stub_request(:get, url).to_return(:status => 200, :body => '{"data": []}', :headers => {})
      Paymill::Transaction.all
      assert_requested :get, url
    end
  end

  describe "create" do
    it "makes a new POST request using the correct API endpoint" do
      url = "https://api.paymill.de/v2/transactions"
      stub_request(:post, url).to_return(:status => 200, :body => '{"data": {}}', :headers => {})
      Paymill::Transaction.create(valid_attributes)
      assert_requested :post, url
    end
  end
  
  describe "refund!" do
    it "makes a new POST request using the correct API endpoint" do
      url = "https://api.paymill.de/v2/refunds/trans_123"
      stub_request(:post, url).to_return(:status => 200, :body => '{"data": {}}', :headers => {})
      transaction.id = 'trans_123'
      transaction.refund!
      assert_requested :post, url
    end
  end
end
