module Paymill
  class Preauthorization < Resource
    # https://www.paymill.com/de-de/dokumentation/referenz/api-referenz/index.html#document-preauthorizations
    # id, string, Unique identifier of this preauthorization
    # amount, string, Formatted amount which will be reserved for further transactions
    # status, enum(open, pending, closed, failed, deleted, preauth), Indicates the current status of this preauthorization
    # livemode, boolean, Whether this preauthorization was issued while being in live mode or not
    # payment, hash, creditcard-object
    # client, hash or null, client-object
    # created_at, integer, Unix-Timestamp for the creation date
    # updated_at, integer, Unix-Timestamp for the last update
    
    attr_reader :amount, :status, :livemode, :payment, :client
#    QUERY_PARAMS = [:count, :offset, :created_at]
  end
end