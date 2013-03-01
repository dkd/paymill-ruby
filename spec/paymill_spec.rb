require "spec_helper"

describe Paymill do
  describe ".request" do
    context "given no api key exists" do
      it "raises an authentication error" do
        expect { Paymill.request(:get, "clients", {}) }.to raise_error(Paymill::AuthenticationError)
      end
    end

    context "with an invalid api key" do
      before(:each) do
        WebMock.stub_request(:any, /#{Paymill::API_BASE}/).to_return(:body => "{}")
        Paymill.api_key = "your-api-key"
      end

      it "attempts to get a url with one param" do
        Paymill.request(:get, "transactions", { param_name: "param_value" })
        WebMock.should have_requested(:get, "https://#{Paymill::api_key}:@#{Paymill::API_BASE}/#{Paymill::API_VERSION}/transactions?param_name=param_value")
      end

      it "attempts to get a url with more than one param" do
        Paymill.request(:get, "transactions", { client: "client_id", order: "created_at_desc" })
        WebMock.should have_requested(:get, "https://#{Paymill::api_key}:@#{Paymill::API_BASE}/#{Paymill::API_VERSION}/transactions?client=client_id&order=created_at_desc")
      end

      it "doesn't add a question mark if no params" do
        Paymill.request(:get, "transactions", {})
        WebMock.should have_requested(:get, "https://#{Paymill::api_key}:@#{Paymill::API_BASE}/#{Paymill::API_VERSION}/transactions")
      end
    end
  end
end
