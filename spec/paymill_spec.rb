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
        WebMock.stub_request(:any, /#{Paymill.api_base}/).to_return(:body => "{}")
        Paymill.api_key = "your-api-key"
      end

      it "attempts to get a url with one param" do
        Paymill.request(:get, "transactions", { param_name: "param_value" })
        WebMock.should have_requested(:get, "https://#{Paymill::api_key}:@#{Paymill::api_base}/#{Paymill::api_version}/transactions?param_name=param_value")
      end

      it "attempts to get a url with more than one param" do
        Paymill.request(:get, "transactions", { client: "client_id", order: "created_at_desc" })
        WebMock.should have_requested(:get, "https://#{Paymill::api_key}:@#{Paymill::api_base}/#{Paymill::api_version}/transactions?client=client_id&order=created_at_desc")
      end

      it "doesn't add a question mark if no params" do
        Paymill.request(:get, "transactions", {})
        WebMock.should have_requested(:get, "https://#{Paymill::api_key}:@#{Paymill::api_base}/#{Paymill::api_version}/transactions")
      end
    end
  end

  describe 'configurations' do
    it 'allows you to set an api key' do
      Paymill.api_key = 'xpto'
      expect(Paymill.api_key).to eq 'xpto'
    end

    it 'allows you to set an api base endpoint' do
      Paymill.api_base = 'xpto'
      expect(Paymill.api_base).to eq 'xpto'
    end

    it 'allows you to set an api version' do
      Paymill.api_version = 'v1'
      expect(Paymill.api_version).to eq 'v1'
    end

    it 'allows you to set an api port' do
      Paymill.api_port = 3000
      expect(Paymill.api_port).to eq 3000
    end

    it 'allows to turn on development mode' do
      Paymill.development = true
      expect(Paymill.development?).to eql(true)
    end

    it 'allows to choose a logger' do
      logger = double(:logger)
      Paymill.logger = logger
      expect(Paymill.logger).to eq logger
    end
  end
end
