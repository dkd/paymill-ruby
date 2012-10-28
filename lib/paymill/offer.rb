module Paymill
  class Offer < Model
    extend Paymill::Operations::Delete
    attr_accessor :id, :name, :amount, :interval, :trial_period_days, :currency, :created_at, :updated_at
  end
end
