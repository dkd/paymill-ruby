module Paymill
  class Subscription < Resource
    # https://www.paymill.com/de-de/dokumentation/referenz/api-referenz/index.html#document-subscriptions
    # id, string, Unique identifier of this subscription
    # plan, hash, Hash describing the offer which is subscribed to the client
    # livemode, boolean, Whether this subscription was issued while being in live mode or not
    # cancel_at_period_end, boolean, Cancel this subscription immediately or at the end of the current period?
    # created_at, integer, Unix-Timestamp for the creation Date
    # updated_at, integer, Unix-Timestamp for the last update
    # canceled_at, integer or null, Unix-Timestamp for the cancel date
    # clients, hash, clients-object
    
    attr_reader :offer, :livemode, :created_at, :updated_at, :canceled_at, :client
    attr_accessor :cancel_at_period_end    
#    QUERY_PARAMS = [:count, :offset, :offer, :canceled_at, :created_at]
  end
end