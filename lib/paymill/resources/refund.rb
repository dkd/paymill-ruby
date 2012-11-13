module Paymill
  class Refund < Resource
    # https://www.paymill.com/de-de/dokumentation/referenz/api-referenz/index.html#document-refunds
    # id, string, Unique identifier of this refund
    # transaction, hash, transactions-object
    # amount, integer (>0), The refunded amount
    # status, enum(open, pending, refunded), Indicates the current status of this transaction.
    # description, string or null, The description given for this refund.
    # livemode, boolean, Whether this refund happend in test- or in livemode.
    # created_at, integer, Unix-Timestamp for the creation date
    # updated_at, integer, Unix-Timestamp for the last update
    
    attr_reader :status, :description
#    QUERY_PARAMS = [:count, :offset, :created_at, :transaction, :client, :amount]

    def amount
      read_money_attribute(:amount)
    end
    
    def live?
      read_attribute(:livemode)
    end
    
    def test?
      !live?
    end
    
    def transaction
      Transaction.new(read_attribute(:transaction))
    end
  end
end