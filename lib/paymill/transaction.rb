module Paymill
  class Transaction < Resource
    include Concerns::LiveMode
    # important to know is that only transactions under a amount of 10,000.00 € will be processed.
    
    # https://www.paymill.com/de-de/dokumentation/referenz/api-referenz/index.html#document-transactions
    # id:            String, Unique identifier of this transaction
    # amount:        String, Formatted amount of this transaction
    # origin_amount: Integer (>0), The used amount, smallest possible unit per currency 
    #                (for euro, we’re calculating the amount in cents)
    # status:        Enum(open, pending, closed, failed, partial_refunded, refunded, preauthorize)
    #                Indicates the current status of this transaction, e.g closed means the transaction is sucessfully transfered, refunded means that the amount is fully or in parts refunded.
    # description:   String or null, 
    #                Need a additional description for this transaction? 
    #                Maybe your shopping cart ID or something like that?
    # livemode:      Boolean,  Whether this transaction was issued while being in live mode or not
    # payment:       Hash, creditcard-object or directdebit-object
    # client:        Hash or null, clients-object
    # preauthorization: Hash or null, preauthorizations-object
    # created_at:    Integer, Unix-Timestamp for the creation date
    # updated_at:    Integer, Unix-Timestamp for the last update
    
    attr_accessor :amount, :origin_amount, :currency, :status, :description, :payment, :refunds, :client, :preauthorization

    def refundable?
      %w(closed partial_refunded).include?(status)
    end

    def refund!(cents=nil, description=nil)
      raise APIError, 'Transaction not refundable' unless refundable?
      cents = amount if cents.nil?
      raise ArgumentError, 'Refund amount is greater than transaction amount' if cents > amount.to_i
      Refund.create(id, amount: cents, description: description)
    end
  end
end
