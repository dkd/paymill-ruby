require "spec_helper"

describe Paymill::Offer do
  let(:valid_attributes) do
    {
      amount: 4200,
      currency: "eur",
      interval: "month",
      name: "Medium Plan"
    }
  end

  let(:offer) do
    Paymill::Offer.new(valid_attributes)
  end

  describe "initialize" do
    it "initializes all attributes correctly" do
      offer.amount.must_equal(4200)
      offer.currency.must_equal("eur")
      offer.interval.must_equal("month")
      offer.name.must_equal("Medium Plan")
    end
  end

  describe "find" do
    it "makes a new GET request using the correct API endpoint to receive a specific offer" do
      url = "https://api.paymill.com/v2/offers/123"
      stub_request(:get, url).to_return(:status => 200, :body => '{"data": {}}', :headers => {})
      Paymill::Offer.find("123")
      assert_requested :get, url
    end
  end
  
  describe "all" do
    it "makes a new GET request using the correct API endpoint to receive all offers" do
      url = "https://api.paymill.com/v2/offers?order=created_at_asc"
      stub_request(:get, url).to_return(:status => 200, :body => '{"data": []}', :headers => {})
      Paymill::Offer.all
      assert_requested :get, url
    end
  end
  
  describe "delete" do
    it "makes a new DELETE request using the correct API endpoint" do
      url = "https://api.paymill.com/v2/offers/123"
      stub_request(:delete, url).to_return(:status => 200, :body => '{"data": []}', :headers => {})
      Paymill::Offer.delete("123")
      assert_requested :delete, url
    end
  end
  
  describe "create" do
    it "makes a new POST request using the correct API endpoint" do
      url = "https://api.paymill.com/v2/offers"
      stub_request(:post, url).to_return(:status => 200, :body => '{"data": {}}', :headers => {})
      Paymill::Offer.create(valid_attributes)
      assert_requested :post, url
    end
  end
end
