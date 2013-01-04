module Paymill
  class Offer < Base
    include Paymill::Operations::Delete
    include Paymill::Operations::Update

    attr_accessor :id, :name, :amount, :interval, :trial_period_days, :currency
  end
end
