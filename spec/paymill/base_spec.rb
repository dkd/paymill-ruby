require "spec_helper"

describe Paymill::Base do
  it "can be converted to a ruby hash" do
    attributes = { id: "some id", created_at: 1362823928 }
    base = Paymill::Base.new(attributes)
    expect(base.to_h).to be == attributes
  end

  describe "#parse_timestamps" do
    context "given #created_at is present" do
      it "creates a Time object" do
        base = Paymill::Base.new(created_at: 1362823928)
        expect(base.created_at.class).to eql(Time)
      end
    end

    context "given #updated_at is present" do
      it "creates a Time object" do
        base = Paymill::Base.new(updated_at: 1362823928)
        expect(base.updated_at.class).to eql(Time)
      end
    end
  end
end
