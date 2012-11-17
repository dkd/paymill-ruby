module Paymill
  class Preauthorization < Resource
    include Concerns::LiveMode
    # https://www.paymill.com/de-de/dokumentation/referenz/api-referenz/index.html#document-preauthorizations
    # id:         String, Unique identifier of this preauthorization
    # amount:     String, Formatted amount which will be reserved for further transactions
    # status:     Enum(open, pending, closed, failed, deleted, preauth), 
    #               Indicates the current status of this preauthorization
    # livemode:   Boolean, Whether this preauthorization was issued while being in live mode or not
    # payment:    Hash, creditcard-object
    # client:     Hash or null, client-object
    # created_at: Integer, Unix-Timestamp for the creation date
    # updated_at: Integer, Unix-Timestamp for the last update
    
    attr_reader :amount, :status, :payment, :client
  end
end