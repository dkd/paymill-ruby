module Paymill
  class Subscription < Base
    include Restful::Update
    include Restful::Delete

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

    def update_amount_once( amount )
      update_amount( amount, 0 )
    end

    def update_amount_permanently( amount )
      update_amount( amount, 1 )
    end

    def update_offer_without_changes( offer )
      update_offer( offer, 0 )
    end

    def update_offer_with_refund( offer )
      update_offer( offer, 1 )
    end

    def update_offer_with_refund_and_capture_date( offer )
      update_offer( offer, 1 )
    end

    def stop_trial_period()
      @offer = nil
      @amount = nil
      @trial_end = nil
      update( trial_end: false )
    end

    def unlimit()
      @offer = nil
      @amount = nil
      @period_of_validity = 'remove'
      update()
    end

    def limit( limit )
      @offer = nil
      @amount = nil
      @period_of_validity = limit
      update()
    end

    def pause()
      @offer = nil
      @amount = nil
      update( pause: true )
    end

    def play()
      @offer = nil
      @amount = nil
      update( pause: false )
    end

    def cancel()
      delete( remove: false )
    end

    def remove()
      delete( remove: true )
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

    def self.mutual_excluded_arguments
      [[:offer], [:amount, :currency, :interval]]
    end

    private
    def update_amount( amount, flag)
      raise ArgumentError( 'amount_change_type should be 0 or 1' ) unless [0, 1].include?( flag )
      @offer = nil
      @amount = amount
      update( amount_change_type: flag )
    end

    def update_offer( offer, flag )
      raise ArgumentError( 'offer_change_type should be between 0 and 2' ) unless (0..2).include?( flag )
      @currency = nil
      @name = nil
      @interval = nil
      @amount = nil
      @payment = nil
      @offer = offer
      update( offer_change_type: 1 )
    end

  end
end
