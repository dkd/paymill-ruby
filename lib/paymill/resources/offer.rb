module Paymill
  class Offer < Resource
    # https://www.paymill.com/de-de/dokumentation/referenz/api-referenz/index.html#document-offers
    # id, string, Unique identifier of this offer
    # name, string, Your name for this offer
    # amount, integer (>0), Every interval the specified amount will be charged. In test mode only even values e.g. 42.00 = 4200 are allowed
    # interval, enum(week, month, year), Defining how often the client should be charged.
    # trial_period_days, integer (>0) or null, Give it a try or charge directly?
    # attribute :id, String
    # attribute :name, String
    # attribute :amount, Money
    # attribute :interval, String
    # attribute :trial_period_days, Integer
    
    
    
    attr_reader :interval, :trial_period_days
    attr_accessor :name
#    QUERY_PARAMS = [:count, :offset, :interval, :amount, :created_at, :trial_period_days]

    def amount
      read_money_attribute(:amount)
    end
  end
end