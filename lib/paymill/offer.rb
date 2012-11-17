module Paymill
  class Offer < Resource
    # https://www.paymill.com/de-de/dokumentation/referenz/api-referenz/index.html#document-offers
    # id:        String, Unique identifier of this offer
    # name:      String, Your name for this offer
    # amount:    Integer (>0), Every interval the specified amount will be charged. 
    #            In test mode only even values e.g. 42.00 = 4200 are allowed
    # interval:  Enum(week, month, year), Defining how often the client should be charged.
    # trial_period_days: Integer (>0) or null, Give it a try or charge directly?

    attr_accessor :name, :amount, :interval, :trial_period_days
  end
end