module Paymill
  class Subscription < Resource
    include Concerns::LiveMode
    # https://www.paymill.com/de-de/dokumentation/referenz/api-referenz/index.html#document-subscriptions
    # id:          String, Unique identifier of this subscription
    # offer:       Hash, Hash describing the offer which is subscribed to the client
    # livemode:    Boolean, Whether this subscription was issued while being in live mode or not
    # cancel_at_period_end: Boolean, Cancel this subscription immediately or at the end of the current period?
    # created_at:  Integer, Unix-Timestamp for the creation Date
    # updated_at:  Integer, Unix-Timestamp for the last update
    # canceled_at: Integer or null, Unix-Timestamp for the cancel date
    # clients:     Hash, clients-object
    
    attr_accessor :offer, :cancel_at_period_end, :canceled_at, :client, :payment, :trial_start, :trial_end
    
    alias :cancel! :delete

    def canceled?
      !canceled_at.nil?
    end
  end
end