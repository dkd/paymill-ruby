require "spec_helper"

describe Paymill::Base do
  describe "#parse_timestamps" do
    context "given #created_at is present" do
      it "creates a Time object" do
        base = Paymill::Base.new(created_at: 1362823928)
        base.created_at.class.should eql(Time)
      end
    end

    context "given #updated_at is present" do
      it "creates a Time object" do
        base = Paymill::Base.new(updated_at: 1362823928)
        base.updated_at.class.should eql(Time)
      end
    end
  end
end
