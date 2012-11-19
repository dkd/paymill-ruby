module Paymill
  class Refund < Resource
    # https://www.paymill.com/de-de/dokumentation/referenz/api-referenz/index.html#document-refunds
    # id:          String, Unique identifier of this refund
    # transaction: Hash, transactions-object
    # amount:      Integer (>0), The refunded amount
    # status:      Enum(open, pending, refunded), Indicates the current status of this transaction.
    # description: String or null, The description given for this refund.
    # livemode:    Boolean, Whether this refund happend in test- or in livemode.
    # created_at:  Integer, Unix-Timestamp for the creation date
    # updated_at:  Integer, Unix-Timestamp for the last update
    
    include Concerns::LiveMode

    attr_accessor :transaction, :amount, :status, :description
    
    def self.create(transaction_id, attributes)
      request_and_build(:post, transaction_id, attributes)
    end    

    def currency
      transaction['currency'] # || Paymill.currency
    end
  end
end