require "spec_helper"

describe Paymill::Request::Base do
  context "#perform" do
    it "performs an https request" do
      allow(Paymill).to receive(:api_key).and_return("some key")
      connection = double
      validator  = double
      allow(Paymill::Request::Connection).to receive(:new).and_return(connection)
      allow(Paymill::Request::Validator).to receive(:new).and_return(validator)

      expect(connection).to receive(:setup_https)
      expect(connection).to receive(:request)
      expect(validator).to receive(:validated_data_for)

      Paymill::Request::Base.new(nil).perform
    end
  end
end
