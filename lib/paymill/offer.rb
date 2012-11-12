module Paymill
  class Offer < Resource
    attr_reader :amount, :interval, :trial_period_days
    attr_accessor :name   
#    QUERY_PARAMS = [:count, :offset, :interval, :amount, :created_at, :trial_period_days]
  end
end