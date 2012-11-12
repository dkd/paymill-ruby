module Paymill
  class Client < Resource
    # https://www.paymill.com/de-de/dokumentation/referenz/api-referenz/index.html#document-clients
    # id, string, Unique identifier of this client
    # email, string or null, Mail address of this client
    # description, string or null, Additional description for this client, perhaps the identifier from your CRM system?
    # created_at, integer, Unix-Timestamp for the creation date
    # updated_at, integer, Unix-Timestamp for the last update
    # payment, list, creditcard-object or directdebit-object
    # subscription, hash or null, subscriptions-object
    
    attr_reader :payment, :subscription
    attr_accessor :email, :description     
#    QUERY_PARAMS = [:count, :offset, :created_at, :creditcard, :email]
  end
end