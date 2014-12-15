module Paymill
  class Offer < Base
    include Restful::Update
    include Restful::Delete

    attr_reader :subscription_count
    attr_accessor :name, :amount, :currency, :interval, :trial_period_days

    def delete_with_subscriptions
      delete( remove_with_subscriptions: true )
    end

    def delete_without_subscriptions
      delete( remove_with_subscriptions: false )
    end

    protected
    def self.allowed_arguments
      [:amount, :currency, :interval, :name, :trial_period_days]
    end

    def self.mandatory_arguments
      [:amount, :currency, :interval, :name]
    end

  end
end
