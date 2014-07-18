require "spec_helper"

describe Paymill::Request::Connection do
  describe "#setup_https" do
    it "creates a https object" do
      connection = Paymill::Request::Connection.new(nil)

      connection.setup_https

      expect(connection.https).not_to be_nil
    end
  end

  describe "#request" do
    it "performs the actual request" do
      connection = Paymill::Request::Connection.new(nil)
      connection.setup_https
      allow(connection).to receive(:https_request)

      expect(connection.https).to receive(:request)

      connection.request
    end

    it 'logs information about the request' do
      info = double(http_method: :post, url: "/some/path", data: params)
      connection = Paymill::Request::Connection.new(info)
      connection.setup_https
      allow(connection).to receive(:https_request)
      allow(connection.https).to receive(:request).and_return(double(code: 200))

      expect(Paymill.logger).to receive(:info)

      connection.request
    end
  end

  describe "#https_request" do
    it "correctly formats the form data" do
      info = double(http_method: :post, url: "/some/path", data: params)
      connection = Paymill::Request::Connection.new(info)
      connection.setup_https

      expect(connection.__send__(:https_request).body.downcase).to eq("email=abc_abc.com&event_types%5b0%5d=transaction.created&event_types%5b1%5d=transaction.failed&event_types%5b2%5d=refund.created&event_types%5b3%5d=invoice.available")
    end
  end

  def params
    {
      email: "abc_abc.com",
      event_types: ["transaction.created","transaction.failed", "refund.created", "invoice.available"]
    }
  end
end
