module Paymill
  class Transaction < Resource
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
    
    attr_accessor :amount, :origin_amount, :status, :description, :livemode, :payment, :client, :preauthrizations
#    QUERY_PARAMS = [:count, :offset, :created_at]
  end
end