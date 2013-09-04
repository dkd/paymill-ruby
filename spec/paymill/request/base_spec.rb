require "spec_helper"

describe Paymill::Request::Base do
  context "#perform" do
    it "checks for an api key" do
      Paymill.stub(:api_key).and_return(nil)

      expect{
        Paymill::Request::Base.new(nil).perform
      }.to raise_error Paymill::AuthenticationError
    end

    it "performs an https request" do
      Paymill.stub(:api_key).and_return("some key")
      connection = double
      validator  = double
      Paymill::Request::Connection.stub(:new).and_return(connection)
      Paymill::Request::Validator.stub(:new).and_return(validator)

      connection.should_receive(:setup_https)
      connection.should_receive(:request)
      validator.should_receive(:validated_data_for)

      Paymill::Request::Base.new(nil).perform
    end
  end
end
