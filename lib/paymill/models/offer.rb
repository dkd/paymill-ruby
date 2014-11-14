module Paymill
  class Offer < Base
    extend Restful::Update
    extend Restful::Delete

    attr_reader :subscription_count
    attr_accessor :name, :amount, :currency, :interval, :trial_period_days

    protected
    def self.allowed_arguments
      [:amount, :currency, :interval, :name, :trial_period_days]
    end

    def self.mandatory_arguments
      [:amount, :currency, :interval, :name]
    end

  end
end
