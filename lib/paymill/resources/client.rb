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
    
    # attribute :id, String, readonly: true
    # attribute :email, String
    # attribute :description, String
    # attribute :created_at, Time, readonly: true
    # attribute :updated_at, Time, readonly: true
    # attribute :payments, Array
    # attribute :subscriptions, Array
    
    attr_accessor :email, :description     
#    QUERY_PARAMS = [:count, :offset, :created_at, :creditcard, :email]

    def subscriptions
      read_array_attribute(:subscription, Subscription)
    end
    
    def payments
      read_array_attribute(:payment, Payment)
    end
  end
end