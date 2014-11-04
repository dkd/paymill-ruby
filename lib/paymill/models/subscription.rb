module Paymill
  class Subscription < Base

    attr_reader :livemode, :temp_amount, :trial_start, :end_of_period, :next_capture_at, :canceled_at, :is_canceled, :is_deleted, :status
    attr_accessor :offer, :amount, :currency, :name, :interval, :trial_end, :period_of_validity, :payment, :client

    protected
    def self.mandatory_arguments
      [:payment]
    end

    def self.allowed_arguments
      [:offer, :payment, :client, :amount, :currency, :interval, :name, :period_of_validity, :start_at]
    end

    def parse_timestamps
      @trial_end        &&= Time.at( @trial_end )
      @canceled_at      &&= Time.at( @canceled_at )
      @trial_start      &&= Time.at( @trial_start)
      @canceled_at      &&= Time.at( @canceled_at )
      @end_of_period    &&= Time.at( @end_of_period )
      @next_capture_at  &&= Time.at( @next_capture_at )
      super
    end

    private
    def self.mutual_excluded_arguments
      [:offer, [:amount, :currency, :interval]]
    end


  end
end
