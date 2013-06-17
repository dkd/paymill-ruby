require "spec_helper"

describe Paymill::Request::Info do
  describe "#url" do
    it "constructs the url" do
      info = Paymill::Request::Info.new(:get, "random", OpenStruct.new(id: 1))

      info.url.should =~ /random/
    end
  end

  describe "#path_with_params" do
    it "does nothing when no params" do
      info = Paymill::Request::Info.new(:get, "random", nil)
      path = "/path/to/someplace"

      info.path_with_params(path, {}).should eq path
    end

    it "constructs the path with params" do
      info = Paymill::Request::Info.new(:get, "random", nil)
      path = "/path/to/someplace"

      info.path_with_params(path, {random: "stuff"}).should eq "#{path}?random=stuff"
    end
  end
end
