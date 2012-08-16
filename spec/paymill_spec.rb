require "spec_helper"

describe Paymill do
  describe ".request" do
    context "given no api key exists" do
      it "raises an authentication error" do
        expect { Paymill.request(:get, Paymill::Client::API_ENDPOINT, {}) }.to raise_error(Paymill::AuthenticationError)
      end
    end
  end
end