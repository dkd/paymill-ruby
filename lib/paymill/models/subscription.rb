module Paymill
  class Subscription < Base
    extend Restful::Update
    extend Restful::Delete

    attr_reader :livemode, :temp_amount, :trial_start, :end_of_period, :next_capture_at, :canceled_at, :currency,
                :is_canceled, :is_deleted, :status, :client, :interval, :payment, :name
    attr_accessor :amount, :offer, :trial_end, :period_of_validity

    def currency=( currency )
      @offer = nil
      @amount = nil
      @currency = currency
    end

    def name=( name )
      @offer = nil
      @amount = nil
      @name = name
    end

    def interval=( interval )
      @offer = nil
      @amount = nil
      @interval = interval
    end

    def payment=( payment )
      @offer = nil
      @amount = nil
      @payment = payment
    end

    def self.update_amount_once( subscription, amount )
      update_amount( subscription, amount, 0 )
    end

    def self.update_amount_permanently( subscription, amount )
      update_amount( subscription, amount, 1 )
    end

    def self.update_offer_without_changes( subscription, offer )
      update_offer( subscription, offer, 0 )
    end

    def self.update_offer_with_refund( subscription, offer )
      update_offer( subscription, offer, 1 )
    end

    def self.update_offer_with_refund_and_capture_date( subscription, offer )
      update_offer( subscription, offer, 1 )
    end

    def self.stop_trial_period(  subscription  )
      subscription.offer = nil
      subscription.amount = nil
      subscription.trial_end = nil
      update( subscription, trial_end: false )
    end

    def self.unlimit( subscription )
      subscription.offer = nil
      subscription.amount = nil
      subscription.period_of_validity = 'remove'
      update( subscription )
    end

    def self.limit( subscription, limit )
      subscription.offer = nil
      subscription.amount = nil
      subscription.period_of_validity = limit
      update( subscription )
    end

    def self.pause( subscription )
      subscription.offer = nil
      subscription.amount = nil
      update( subscription, pause: true )
    end

    def self.play( subscription )
      subscription.offer = nil
      subscription.amount = nil
      update( subscription, pause: false )
    end

    def self.cancel( subscription )
      delete( subscription, remove: false )
      # find( subscription )
      # binding.pry
    end

    def self.remove( subscription )
      delete( subscription, remove: true )
      # find( subscription )
    end

    protected
    def self.create_with?( incoming_arguments )
      raise ArgumentError unless incoming_arguments.include?( :offer ) || (mutual_excluded_arguments.last - incoming_arguments).empty?
      super( incoming_arguments - mutual_excluded_arguments.flatten )
    end

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
      [[:offer], [:amount, :currency, :interval]]
    end

    def self.update_amount( subscription, amount, flag)
      raise ArgumentError( 'amount_change_type should be 0 or 1' ) unless [0, 1].include?( flag )
      subscription.offer = nil
      subscription.amount = amount
      update( subscription, amount_change_type: flag )
    end

    def self.update_offer( subscription, offer, flag )
      raise ArgumentError( 'offer_change_type should be between 0 and 2' ) unless (0..2).include?( flag )
      subscription.currency = nil
      subscription.name = nil
      subscription.interval = nil
      subscription.amount = nil
      subscription.payment = nil
      subscription.offer = offer
      update( subscription, offer_change_type: 1 )
    end

  end
end
