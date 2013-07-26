require "spec_helper"

describe Paymill::Request::Connection do
  describe "#setup_https" do
    it "creates a https object" do
      connection = Paymill::Request::Connection.new(nil)

      connection.setup_https

      connection.https.should_not be_nil
    end
  end

  describe "#request" do
    it "performs the actual request" do
      connection = Paymill::Request::Connection.new(nil)
      connection.setup_https
      connection.stub(:https_request)

      connection.https.should_receive(:request)

      connection.request
    end
  end

  describe "#https_request" do
    it "correctly formats the form data" do
      info = double(http_method: :post, url: "/some/path", data: params)
      connection = Paymill::Request::Connection.new info
      connection.setup_https

      connection.send(:https_request).body.should eq "email=abc_abc.com&event_types%5B0%5D=transaction.created&event_types%5B1%5D=transaction.failed&event_types%5B2%5D=refund.created&event_types%5B3%5D=invoice.available"
    end
  end

  def params
    {
      email: "abc_abc.com",
      event_types: ["transaction.created","transaction.failed", "refund.created", "invoice.available"]
    }
  end
end
