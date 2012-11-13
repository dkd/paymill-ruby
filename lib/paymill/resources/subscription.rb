module Paymill
  class Subscription < Resource
    # https://www.paymill.com/de-de/dokumentation/referenz/api-referenz/index.html#document-subscriptions
    # id, string, Unique identifier of this subscription
    # offer, hash, Hash describing the offer which is subscribed to the client
    # livemode, boolean, Whether this subscription was issued while being in live mode or not
    # cancel_at_period_end, boolean, Cancel this subscription immediately or at the end of the current period?
    # created_at, integer, Unix-Timestamp for the creation Date
    # updated_at, integer, Unix-Timestamp for the last update
    # canceled_at, integer or null, Unix-Timestamp for the cancel date
    # clients, hash, clients-object
    
    # attribute :offer, Offer
    # attribute :livemode, Boolean
    # attribute :cancel_at_period_end, Boolean
    # attribute :canceled_at, Time
    # attribute :client, Client
    
    attr_reader :offer, :client
    attr_writer :cancel_at_period_end    
#    QUERY_PARAMS = [:count, :offset, :offer, :canceled_at, :created_at]

    def cancel_at_period_end?
      read_attribute(:cancel_at_period_end)
    end
    
    def canceled_at
      read_time_attribute(:canceled_at)
    end
    
    def live?
      read_attribute(:livemode)
    end
    
    def test?
      !live?
    end
    
    def offer
      Offer.new(read_attribute(:offer))
    end
  end
end