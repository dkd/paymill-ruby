require "spec_helper"

describe Paymill::Refund do
  let(:valid_attributes) do
    { 
      id: "refund_87bc404a95d5ce616049",
      amount: "042",
      status: "refunded",
      description: nil,
      livemode: false,
      created_at: 1349947042, 
      updated_at: 1349947042,
      transaction: {
        id: "tran_2848cb20a6bb578177db",
        amount: "378",
        origin_amount: 420,
        status: "partial_refunded",
        description: nil,
        livemode: false,
        created_at: 1349946216,
        updated_at: 1349947042,
        response_code: 20000,
        refunds: [
          {
              id: "refund_87bc404a95d5ce616049",
              amount: "042",
              status: "refunded",
              description: nil,
              livemode: false,
              created_at: 1349947042,
              updated_at: 1349947042,
              response_code: 20000
          }
        ],
        payment: {
          id: "pay_95ba26ba2c613ebb0ca8",
          type: "debit",
          client: "client_64b025ee5955abd5af66",
          code: "860555000",
          holder: "Max Mustermann",
          account: "******2345",
          created_at: 1349945681,
          updated_at: 1349945681
        },
        client: {
          id: "client_64b025ee5955abd5af66",
          email: "lovely-client@example.com",
          description: nil,
          created_at: 1349945644,
          updated_at: 1349945644,
          payment: [
              "pay_95ba26ba2c613ebb0ca8"
          ],
          subscription: nil
        },
        preauthorization: nil
      }
    }
  end

  let (:refund) do
    Paymill::Refund.new(valid_attributes)
  end

  describe "#initialize" do
    it "initializes all attributes correctly" do
      refund.id.should eql("refund_87bc404a95d5ce616049")
      refund.amount.should eql("042")
      refund.status.should eql("refunded")
      refund.description.should be_nil
      refund.livemode.should be_false
=begin
      refund.transaction[:refunds].should eql(
        [
          {
              id: "refund_87bc404a95d5ce616049",
              amount: "042",
              status: "refunded",
              description: nil,
              livemode: false,
              created_at: 1349947042,
              updated_at: 1349947042,
              response_code: 20000
          }
        ]
      )
      refund.transaction[:payment].should eql(
        {
          id: "pay_95ba26ba2c613ebb0ca8",
          type: "debit",
          client: "client_64b025ee5955abd5af66",
          code: "860555000",
          holder: "Max Mustermann",
          account: "******2345",
          created_at: 1349945681,
          updated_at: 1349945681
        }
      )
      refund.transaction[:client].should eql(
        id: "client_64b025ee5955abd5af66",
        email: "lovely-client@example.com",
        description: nil,
        created_at: 1349945644,
        updated_at: 1349945644,
        payment: [
            "pay_95ba26ba2c613ebb0ca8"
        ],
        subscription: nil
      )
=end
    end
  end

  describe ".create" do
    it "makes a new POST request using the correct API endpoint" do
      Paymill.should_receive(:request).with(:post, "refunds", valid_attributes).and_return("data" => {})
      Paymill::Refund.create(valid_attributes)
    end
  end
end
