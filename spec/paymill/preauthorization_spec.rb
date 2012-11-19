require 'spec_helper'

describe Paymill::Preauthorization do
  describe "Naming" do
    it "should return the correct collection_name" do
      Paymill::Preauthorization.collection_name.must_equal 'preauthorizations'
    end

    it "should return the correct api_path" do
      Paymill::Preauthorization.api_path.must_equal 'preauthorizations'
      Paymill::Preauthorization.api_path(123).must_equal 'preauthorizations/123'
    end
  end
end