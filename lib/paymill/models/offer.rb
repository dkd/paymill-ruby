module Paymill
  class Offer < Base
    extend Paymill::Restful::Update
    extend Paymill::Restful::Delete

    attr_reader :subscription_count
    attr_accessor :name, :amount, :currency, :interval, :trial_period_days

    # def self.update_with_correlated_subscriptions( offer )
    #   update( offer, update_subscriptions: true )
    # end
    #
    # def self.delete( offer )
    #   super( offer, remove_with_subscriptions: false )
    # end
    #
    # def self.delete_with_correlated_subscriptions( offer )
    #   delete( offer, remove_with_subscriptions: true )
    # end

    protected
    def self.allowed_arguments
      [:amount, :currency, :interval, :name, :trial_period_days]
    end

    def self.mandatory_arguments
      [:amount, :currency, :interval, :name]
    end

  end
end
