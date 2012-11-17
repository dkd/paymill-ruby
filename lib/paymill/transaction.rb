module Paymill
  class Transaction < Resource
    include Concerns::LiveMode
    # important to know is that only transactions under a amount of 10,000.00 € will be processed.
    
    # https://www.paymill.com/de-de/dokumentation/referenz/api-referenz/index.html#document-transactions
    # id, string, Unique identifier of this transaction
    # amount, string, Formatted amount of this transaction
    # origin_amount, integer (>0), The used amount, smallest possible unit per currency (for euro, we’re calculating the amount in cents)
    # status, enum(open, pending, closed, failed, partial_refunded, refunded, preauthorize), Indicates the current status of this transaction, e.g closed means the transaction is sucessfully transfered, refunded means that the amount is fully or in parts refunded.
    # description, string or null, Need a additional description for this transaction? Maybe your shopping cart ID or something like that?
    # livemode, boolean,  Whether this transaction was issued while being in live mode or not
    # payment, hash, creditcard-object or directdebit-object
    # client, hash or null, clients-object
    # preauthorization, hash or null, preauthorizations-object
    # created_at, integer, Unix-Timestamp for the creation date
    # updated_at, integer, Unix-Timestamp for the last update
    # 
    # Create new Transaction with ...
    # - Token
    # - Payment
    # - Client & Payment
    # - Preauthorization
    
    attr_accessor :amount, :origin_amount, :status, :description, :payment, :client, :preauthorization

    def refundable?
      %w(closed partial_refunded).include?(status)
    end

    def refund!(cents=nil, description=nil)
      # raise something unless refundable?
      amount = cents || self.amount.cents
      Refund.create(id, amount: amount, description: description)
    end
  end
end