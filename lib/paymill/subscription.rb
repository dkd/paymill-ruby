module Paymill
  class Subscription < Resource
    attr_reader :offer, :livemode, :created_at, :updated_at, :canceled_at, :client
    attr_accessor :cancel_at_period_end    
#    QUERY_PARAMS = [:count, :offset, :offer, :canceled_at, :created_at]
  end
end