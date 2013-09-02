require "spec_helper"

describe Paymill::Request::Validator do
  describe "#validated_data_for" do
    it "validates the data" do
      info = Paymill::Request::Info.new(:get, "random", OpenStruct.new(id: 1))
      validator = Paymill::Request::Validator.new info
      response = OpenStruct.new(body: '{"response":"ok"}', code: 200)

      validator.validated_data_for(response).should eq "response" => "ok"
    end
  end
end
