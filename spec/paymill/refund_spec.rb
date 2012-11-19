require 'spec_helper'

describe Paymill::Refund do
  describe "Naming" do
    it "should return the correct collection_name" do
      Paymill::Refund.collection_name.must_equal 'refunds'
    end

    it "should return the correct api_path" do
      Paymill::Refund.api_path.must_equal 'refunds'
      Paymill::Refund.api_path(123).must_equal 'refunds/123'
    end
  end
end