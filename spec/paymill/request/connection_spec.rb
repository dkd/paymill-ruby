require "spec_helper"

describe Paymill::Request::Connection do
  context "#setup_https" do
    it "creates a https object" do
      connection = Paymill::Request::Connection.new(nil)

      connection.setup_https

      connection.https.should_not be_nil
    end
  end

  context "#request" do
    it "performs the actual request" do
      connection = Paymill::Request::Connection.new(nil)
      connection.setup_https
      connection.stub(:https_request)

      connection.https.should_receive(:request)

      connection.request
    end
  end
end
