require 'spec_helper'

module Paymill
  describe Subscription do

    let( :amount ) { 2990 }
    let( :currency ) { 'USD' }
    let( :interval ) { '1 MONTH' }
    let( :token ) { '098f6bcd4621d373cade4e832627b4f6' }
    let( :client ) { Client.create( email: 'rocky.balboa@qaiware.com' ) }
    let( :payment ) { Payment.create( token: token, client: client ) }
    let( :offer ) { Offer.create( amount: amount, currency: currency, interval: interval, name: 'Premium Stallion' ) }

    subscription_id = nil

    context '::create' do
      it 'should create subscription from offer', :vcr do
        subscription = Subscription.create( offer: offer, payment: payment, client: client )

        expect( subscription ).to be_a Subscription

        expect( subscription.id ).to be_a String
        expect( subscription.offer.id ).to eq offer.id
        expect( subscription.livemode ).to be false
        expect( subscription.amount ).to be amount
        expect( subscription.temp_amount ).to be_nil
        expect( subscription.currency ).to eq currency
        expect( subscription.name ).to eq 'Premium Stallion'
        expect( subscription.interval ).to eq interval
        expect( subscription.trial_start ).to be_nil
        expect( subscription.trial_end ).to be_nil
        expect( subscription.period_of_validity ).to be_nil
        expect( subscription.end_of_period ).to be_nil
        expect( subscription.next_capture_at ).to be_a Time
        expect( subscription.created_at ).to be_a Time
        expect( subscription.updated_at ).to be_a Time
        expect( subscription.canceled_at ).to be_nil
        expect( subscription.payment.id ).to eq payment.id
        expect( subscription.app_id ).to be_nil
        expect( subscription.is_canceled ).to be false
        expect( subscription.is_deleted ).to be false
        expect( subscription.status ).to eq 'active'
        expect( subscription.client.id ).to eq client.id
      end

      it 'should throw ArgumentError when creating subscription without offer', :vcr do
        expect{ Subscription.create( payment: payment ) }.to raise_error ArgumentError
      end

      it 'should throw ArgumentError when creating subscription without interval', :vcr do
        expect{ Subscription.create( payment: payment, amount: amount, currency: currency ) }.to raise_error ArgumentError
      end

      it 'should create subscription without offer', :vcr do
        subscription = Subscription.create( payment: payment, client: client, amount: amount, currency: currency, interval: interval )

        expect( subscription ).to be_a Subscription

        expect( subscription.id ).to be_a String
        expect( subscription.offer.amount ).to be amount
        expect( subscription.offer.currency ).to eq currency
        expect( subscription.offer.interval ).to eq interval
        expect( subscription.livemode ).to be false
        expect( subscription.amount ).to be amount
        expect( subscription.temp_amount ).to be_nil
        expect( subscription.currency ).to eq currency
        expect( subscription.name ).to be_empty
        expect( subscription.interval ).to eq interval
        expect( subscription.trial_start ).to be_nil
        expect( subscription.trial_end ).to be_nil
        expect( subscription.period_of_validity ).to be_nil
        expect( subscription.end_of_period ).to be_nil
        expect( subscription.next_capture_at ).to be_a Time
        expect( subscription.created_at ).to be_a Time
        expect( subscription.updated_at ).to be_a Time
        expect( subscription.canceled_at ).to be_nil
        expect( subscription.payment.id ).to eq payment.id
        expect( subscription.app_id ).to be_nil
        expect( subscription.is_canceled ).to be false
        expect( subscription.is_deleted ).to be false
        expect( subscription.status ).to eq 'active'
        expect( subscription.client.id ).to eq client.id
        expect( subscription.client.email ).to eq client.email
      end

      it 'should create subscription without offer and new payment', :vcr do
        subscription = Subscription.create( payment: Payment.create( token: token), amount: amount, currency: currency, interval: interval )

        expect( subscription ).to be_a Subscription

        expect( subscription.id ).to be_a String
        expect( subscription.offer.amount ).to be amount
        expect( subscription.offer.currency ).to eq currency
        expect( subscription.offer.interval ).to eq interval
        expect( subscription.livemode ).to be false
        expect( subscription.amount ).to be amount
        expect( subscription.temp_amount ).to be_nil
        expect( subscription.currency ).to eq currency
        expect( subscription.name ).to be_empty
        expect( subscription.interval ).to eq interval
        expect( subscription.trial_start ).to be_nil
        expect( subscription.trial_end ).to be_nil
        expect( subscription.period_of_validity ).to be_nil
        expect( subscription.end_of_period ).to be_nil
        expect( subscription.next_capture_at ).to be_a Time
        expect( subscription.created_at ).to be_a Time
        expect( subscription.updated_at ).to be_a Time
        expect( subscription.canceled_at ).to be_nil
        expect( subscription.payment.id ).not_to eq payment.id
        expect( subscription.app_id ).to be_nil
        expect( subscription.is_canceled ).to be false
        expect( subscription.is_deleted ).to be false
        expect( subscription.status ).to eq 'active'
        expect( subscription.client.id ).not_to eq client.id
        expect( subscription.client.email ).to be_nil
      end

      xit 'should create subscription without offer with client and new payment', :vcr do
        subscription = Subscription.create( payment: Payment.create( token: token), client: client, amount: amount, currency: currency, interval: interval )

        expect( subscription ).to be_a Subscription

        expect( subscription.id ).to be_a String
        expect( subscription.offer.amount ).to be amount
        expect( subscription.offer.currency ).to eq currency
        expect( subscription.offer.interval ).to eq interval
        expect( subscription.livemode ).to be false
        expect( subscription.amount ).to be amount
        expect( subscription.temp_amount ).to be_nil
        expect( subscription.currency ).to eq currency
        expect( subscription.name ).to be_empty
        expect( subscription.interval ).to eq interval
        expect( subscription.trial_start ).to be_nil
        expect( subscription.trial_end ).to be_nil
        expect( subscription.period_of_validity ).to be_nil
        expect( subscription.end_of_period ).to be_nil
        expect( subscription.next_capture_at ).to be_a Time
        expect( subscription.created_at ).to be_a Time
        expect( subscription.updated_at ).to be_a Time
        expect( subscription.canceled_at ).to be_nil
        expect( subscription.payment.id ).not_to eq payment.id
        expect( subscription.app_id ).to be_nil
        expect( subscription.is_canceled ).to be false
        expect( subscription.is_deleted ).to be false
        expect( subscription.status ).to eq 'active'
        expect( subscription.client.id ).to eq client.id
        expect( subscription.client.email ).to eq client.email
      end

      it 'should create subscription without offer with name and period_of_validity and start_at', :vcr do
        subscription = Subscription.create( payment: payment, amount: amount, currency: currency, interval: interval, name: 'Basic Stallion', period_of_validity: '2 YEAR', start_at: 2.days.from_now )
        subscription_id = subscription.id

        expect( subscription ).to be_a Subscription

        expect( subscription.id ).to be_a String
        expect( subscription.offer.amount ).to be amount
        expect( subscription.offer.currency ).to eq currency
        expect( subscription.offer.interval ).to eq interval
        expect( subscription.offer.name ).to eq 'Basic Stallion'
        expect( subscription.livemode ).to be false
        expect( subscription.amount ).to be amount
        expect( subscription.temp_amount ).to be_nil
        expect( subscription.currency ).to eq currency
        expect( subscription.name ).to eq 'Basic Stallion'
        expect( subscription.interval ).to eq interval
        expect( subscription.trial_start ).to be_a Time
        expect( subscription.trial_end ).to be_a Time
        expect( subscription.period_of_validity ).to eq '2 YEAR'
        expect( subscription.end_of_period ).to be_a Time
        expect( subscription.next_capture_at ).to be_a Time
        expect( subscription.created_at ).to be_a Time
        expect( subscription.updated_at ).to be_a Time
        expect( subscription.canceled_at ).to be_nil
        expect( subscription.payment.id ).to eq payment.id
        expect( subscription.app_id ).to be_nil
        expect( subscription.is_canceled ).to be false
        expect( subscription.is_deleted ).to be false
        expect( subscription.status ).to eq 'active'
        expect( subscription.client.id ).to eq client.id
        expect( subscription.client.email ).to eq client.email
      end

      it 'should creaate subscription with offer and different values', :vcr do
        subscription = Subscription.create( payment: payment, amount: 777, currency: 'EUR', interval: '1 WEEK', offer: offer )

        expect( subscription ).to be_a Subscription

        expect( subscription.id ).to be_a String
        expect( subscription.offer.amount ).to be amount
        expect( subscription.offer.currency ).to eq currency
        expect( subscription.offer.interval ).to eq interval
        expect( subscription.offer.name ).to eq 'Premium Stallion'
        expect( subscription.livemode ).to be false
        expect( subscription.amount ).to be 777
        expect( subscription.temp_amount ).to be_nil
        expect( subscription.currency ).to eq 'EUR'
        expect( subscription.name ).to eq 'Premium Stallion'
        expect( subscription.interval ).to eq '1 WEEK'
        expect( subscription.trial_start ).to be_nil
        expect( subscription.trial_end ).to be_nil
        expect( subscription.period_of_validity ).to be_nil
        expect( subscription.end_of_period ).to be_nil
        expect( subscription.next_capture_at ).to be_a Time
        expect( subscription.created_at ).to be_a Time
        expect( subscription.updated_at ).to be_a Time
        expect( subscription.canceled_at ).to be_nil
        expect( subscription.payment.id ).to eq payment.id
        expect( subscription.app_id ).to be_nil
        expect( subscription.is_canceled ).to be false
        expect( subscription.is_deleted ).to be false
        expect( subscription.status ).to eq 'active'
        expect( subscription.client.id ).to eq client.id
        expect( subscription.client.email ).to eq client.email
      end
    end

    context '::find' do
      it 'should find a subscription by given id', :vcr do
        expect( Subscription.find( subscription_id ).id ).to eq subscription_id
      end

      it 'should throw PaymillError by given fake id', :vcr do
        expect{ Subscription.find( 'fake_id' ).id }.to raise_error PaymillError
      end
    end

    context '::update' do
      it 'should update all "instance" attributes without the offer', :vcr do
        subscription = Subscription.create( payment: payment, amount: amount, currency: currency, interval: interval, name: 'Basic Stallion', period_of_validity: '2 YEAR', start_at: 2.days.from_now )

        subscription.payment = Payment.create( token: token, client: client )
        payment_id = subscription.payment.id
        subscription.currency = 'EUR'
        subscription.interval = '1 MONTH,FRIDAY'
        subscription.name = 'Changed Subscription'
        subscription.period_of_validity = '14 MONTH'

        subscription.update

        expect( subscription ).to be_a Subscription

        expect( subscription.id ).to be_a String
        expect( subscription.offer.amount ).to be amount
        expect( subscription.offer.currency ).to eq currency
        expect( subscription.offer.interval ).to eq interval
        expect( subscription.offer.name ).to eq 'Basic Stallion'
        expect( subscription.livemode ).to be false
        expect( subscription.amount ).to be amount
        expect( subscription.temp_amount ).to be_nil
        expect( subscription.currency ).to eq 'EUR'
        expect( subscription.name ).to eq 'Changed Subscription'
        expect( subscription.interval ).to eq '1 MONTH,FRIDAY'
        expect( subscription.trial_start ).to be_a Time
        expect( subscription.trial_end ).to be_a Time
        expect( subscription.period_of_validity ).to eq '14 MONTH'
        expect( subscription.end_of_period ).to be_a Time
        expect( subscription.next_capture_at ).to be_a Time
        expect( subscription.created_at ).to be_a Time
        expect( subscription.updated_at ).to be_a Time
        expect( subscription.canceled_at ).to be_nil
        expect( subscription.payment.id ).to eq payment_id
        expect( subscription.app_id ).to be_nil
        expect( subscription.is_canceled ).to be false
        expect( subscription.is_deleted ).to be false
        expect( subscription.status ).to eq 'active'
        expect( subscription.client.id ).to eq client.id
        expect( subscription.client.email ).to eq client.email
        expect( subscription.created_at ).to be < subscription.updated_at
      end

      it 'should change the amount of a subscription once', :vcr do
        subscription = Subscription.create( payment: payment, offer: offer )

        subscription.update_amount_once( 1717 )

        expect( subscription.id ).to be_a String
        expect( subscription.offer.amount ).to be amount
        expect( subscription.offer.currency ).to eq currency
        expect( subscription.offer.interval ).to eq interval
        expect( subscription.offer.name ).to eq offer.name
        expect( subscription.livemode ).to be false
        expect( subscription.amount ).to be amount
        expect( subscription.temp_amount ).to be 1717
        expect( subscription.currency ).to eq currency
        expect( subscription.name ).to eq offer.name
        expect( subscription.interval ).to eq interval
        expect( subscription.trial_start ).to be_nil
        expect( subscription.trial_end ).to be_nil
        expect( subscription.period_of_validity ).to be_nil
        expect( subscription.end_of_period ).to be_nil
        expect( subscription.next_capture_at ).to be_a Time
        expect( subscription.created_at ).to be_a Time
        expect( subscription.updated_at ).to be_a Time
        expect( subscription.canceled_at ).to be_nil
        expect( subscription.app_id ).to be_nil
        expect( subscription.is_canceled ).to be false
        expect( subscription.is_deleted ).to be false
        expect( subscription.status ).to eq 'active'
        expect( subscription.client.email ).to eq client.email
        expect( subscription.created_at ).to be < subscription.updated_at
      end

      it 'should change the amount of a subscription permanently', :vcr do
        subscription = Subscription.find( subscription_id )

        subscription.update_amount_permanently( 1717 )

        expect( subscription.id ).to be_a String
        expect( subscription.offer.amount ).to be amount
        expect( subscription.offer.currency ).to eq currency
        expect( subscription.offer.interval ).to eq interval
        expect( subscription.offer.name ).to eq 'Basic Stallion'
        expect( subscription.livemode ).to be false
        expect( subscription.amount ).to be 1717
        expect( subscription.temp_amount ).to be_nil
        expect( subscription.currency ).to eq currency
        expect( subscription.name ).to eq 'Basic Stallion'
        expect( subscription.interval ).to eq interval
        expect( subscription.trial_start ).to be_a Time
        expect( subscription.trial_end ).to be_a Time
        expect( subscription.period_of_validity ).to eq '2 YEAR'
        expect( subscription.end_of_period ).to be_a Time
        expect( subscription.next_capture_at ).to be_a Time
        expect( subscription.created_at ).to be_a Time
        expect( subscription.updated_at ).to be_a Time
        expect( subscription.canceled_at ).to be_nil
        expect( subscription.app_id ).to be_nil
        expect( subscription.is_canceled ).to be false
        expect( subscription.is_deleted ).to be false
        expect( subscription.status ).to eq 'active'
        expect( subscription.client.email ).to eq client.email
        expect( subscription.created_at ).to be < subscription.updated_at
      end

      it 'should change the offer of a subscription with no refund and unchanged capture date', :vcr do
        subscription = Subscription.create( payment: payment, offer: offer )
        new_offer = Offer.create( name: 'Foo', amount: 4990, currency: 'EUR', interval: '2 WEEK')

        subscription.update_offer_without_changes( new_offer )

        expect( subscription.id ).to be_a String
        expect( subscription.offer.amount ).to be new_offer.amount
        expect( subscription.offer.currency ).to eq new_offer.currency
        expect( subscription.offer.interval ).to eq new_offer.interval
        expect( subscription.offer.name ).to eq new_offer.name
        expect( subscription.livemode ).to be false
        expect( subscription.amount ).to be new_offer.amount
        expect( subscription.temp_amount ).to be_nil
        expect( subscription.currency ).to eq new_offer.currency
        expect( subscription.name ).to eq new_offer.name
        expect( subscription.interval ).to eq new_offer.interval
        expect( subscription.trial_start ).to be_nil
        expect( subscription.trial_end ).to be_nil
        expect( subscription.period_of_validity ).to be_nil
        expect( subscription.end_of_period ).to be_nil
        expect( subscription.next_capture_at ).to be_a Time
        expect( subscription.created_at ).to be_a Time
        expect( subscription.updated_at ).to be_a Time
        expect( subscription.canceled_at ).to be_nil
        expect( subscription.app_id ).to be_nil
        expect( subscription.is_canceled ).to be false
        expect( subscription.is_deleted ).to be false
        expect( subscription.status ).to eq 'active'
        expect( subscription.client.email ).to eq client.email
        expect( subscription.created_at ).to be < subscription.updated_at
      end

      it 'should change the offer of a subscription with refund and unchanged capture date', :vcr do
        subscription = Subscription.create( payment: payment, offer: offer )
        new_offer = Offer.create( name: 'Foo', amount: 1990, currency: 'EUR', interval: '2 WEEK')

        subscription.update_offer_with_refund( new_offer )

        expect( subscription.id ).to be_a String
        expect( subscription.offer.amount ).to be new_offer.amount
        expect( subscription.offer.currency ).to eq new_offer.currency
        expect( subscription.offer.interval ).to eq new_offer.interval
        expect( subscription.offer.name ).to eq new_offer.name
        expect( subscription.livemode ).to be false
        expect( subscription.amount ).to be new_offer.amount
        expect( subscription.temp_amount ).to be_nil
        expect( subscription.currency ).to eq new_offer.currency
        expect( subscription.name ).to eq new_offer.name
        expect( subscription.interval ).to eq new_offer.interval
        expect( subscription.trial_start ).to be_nil
        expect( subscription.trial_end ).to be_nil
        expect( subscription.period_of_validity ).to be_nil
        expect( subscription.end_of_period ).to be_nil
        expect( subscription.next_capture_at ).to be_a Time
        expect( subscription.created_at ).to be_a Time
        expect( subscription.updated_at ).to be_a Time
        expect( subscription.canceled_at ).to be_nil
        expect( subscription.app_id ).to be_nil
        expect( subscription.is_canceled ).to be false
        expect( subscription.is_deleted ).to be false
        expect( subscription.status ).to eq 'active'
        expect( subscription.client.email ).to eq client.email
        expect( subscription.created_at ).to be < subscription.updated_at
      end

      it 'should change the offer of a subscription with refund and capture date', :vcr do
        subscription = Subscription.create( payment: payment, offer: offer )
        new_offer = Offer.create( name: 'Foo', amount: 1990, currency: 'EUR', interval: '2 WEEK')

        subscription.update_offer_with_refund_and_capture_date( new_offer )

        expect( subscription.id ).to be_a String
        expect( subscription.offer.amount ).to be new_offer.amount
        expect( subscription.offer.currency ).to eq new_offer.currency
        expect( subscription.offer.interval ).to eq new_offer.interval
        expect( subscription.offer.name ).to eq new_offer.name
        expect( subscription.livemode ).to be false
        expect( subscription.amount ).to be new_offer.amount
        expect( subscription.temp_amount ).to be_nil
        expect( subscription.currency ).to eq new_offer.currency
        expect( subscription.name ).to eq new_offer.name
        expect( subscription.interval ).to eq new_offer.interval
        expect( subscription.trial_start ).to be_nil
        expect( subscription.trial_end ).to be_nil
        expect( subscription.period_of_validity ).to be_nil
        expect( subscription.end_of_period ).to be_nil
        expect( subscription.next_capture_at ).to be_a Time
        expect( subscription.created_at ).to be_a Time
        expect( subscription.updated_at ).to be_a Time
        expect( subscription.canceled_at ).to be_nil
        expect( subscription.app_id ).to be_nil
        expect( subscription.is_canceled ).to be false
        expect( subscription.is_deleted ).to be false
        expect( subscription.status ).to eq 'active'
        expect( subscription.client.email ).to eq client.email
        expect( subscription.created_at ).to be < subscription.updated_at
      end

      it 'should stops the trial period', :vcr do
        subscription = Subscription.create( payment: payment, amount: amount, currency: currency, interval: interval, name: 'Bar', start_at: Time.new( 2016, 11, 17, 15, 0, 0 ).to_i )
        next_capture_at = subscription.next_capture_at
        expect( subscription.trial_end.beginning_of_day ).to eq Time.new( 2016, 11, 17, 15, 0, 0 ).beginning_of_day

        subscription.stop_trial_period()

        expect( subscription.trial_end ).to be_nil
        expect( subscription.next_capture_at ).to be < next_capture_at
        expect( subscription.created_at ).to be < subscription.updated_at
      end

      it 'should unlimit-limit the validity of a subscription', :vcr do
        subscription = Subscription.create( payment: payment, offer: offer, name: 'Baz', period_of_validity: '2 MONTH' )
        expect( subscription.period_of_validity ).to eq '2 MONTH'
        expect( subscription.end_of_period ).not_to be_nil

        subscription.unlimit
        expect( subscription.end_of_period ).to be_nil
        expect( subscription.period_of_validity ).to be_nil

        subscription.limit( '3 MONTH' )
        expect( subscription.end_of_period ).to be_a Time
        expect( subscription.period_of_validity ).to eq '3 MONTH'
        expect( subscription.created_at ).to be < subscription.updated_at
      end

      it 'should pause-play a subscription', :vcr do
        subscription = Subscription.create( payment: payment, offer: offer, name: 'To Delete' )
        expect( subscription.period_of_validity ).to be_nil
        expect( subscription.end_of_period ).to be_nil

        subscription.pause
        expect( subscription.status ).to eq 'inactive'

        subscription.play
        expect( subscription.status ).to eq 'active'
        expect( subscription.created_at ).to be < subscription.updated_at
      end

      it "should update subscription's currency", :vcr do
        subscription = Subscription.find( subscription_id )
        subscription.currency = 'BGN'
        subscription.update

        expect( subscription.currency ).to eq 'BGN'
        expect( subscription.created_at ).to be < subscription.updated_at
      end

      it "should update subscription's name", :vcr do
        subscription = Subscription.find( subscription_id )
        subscription.name = 'goo'
        subscription.update

        expect( subscription.name ).to eq 'goo'
        expect( subscription.created_at ).to be < subscription.updated_at
      end

      it "should update subscription's interval", :vcr do
        subscription = Subscription.find( subscription_id )
        subscription.interval = '5 WEEK'
        subscription.update

        expect( subscription.interval ).to eq '5 WEEK'
        expect( subscription.created_at ).to be < subscription.updated_at
      end

      it "should update subscription's payment", :vcr do
        new_payment = Payment.create( token: token, client: client )
        subscription = Subscription.find( subscription_id )
        subscription.payment = new_payment
        subscription.update

        expect( subscription.payment.id ).to eq new_payment.id
        expect( subscription.created_at ).to be < subscription.updated_at
      end
    end

    context '::delete' do
      it 'should cancel the given subscription', :vcr do
          subscription = Subscription.create( payment: payment, offer: offer, name: 'To Delete' ).cancel

          expect( subscription.id ).to be_a String
          expect( subscription.offer.amount ).to be offer.amount
          expect( subscription.offer.currency ).to eq offer.currency
          expect( subscription.offer.interval ).to eq offer.interval
          expect( subscription.offer.name ).to eq offer.name
          expect( subscription.livemode ).to be false
          expect( subscription.amount ).to be offer.amount
          expect( subscription.temp_amount ).to be_nil
          expect( subscription.currency ).to eq offer.currency
          expect( subscription.name ).to eq 'To Delete'
          expect( subscription.interval ).to eq offer.interval
          expect( subscription.trial_start ).to be_nil
          expect( subscription.trial_end ).to be_nil
          expect( subscription.period_of_validity ).to be_nil
          expect( subscription.end_of_period ).to be_nil
          expect( subscription.next_capture_at ).to be_nil
          expect( subscription.created_at ).to be_a Time
          expect( subscription.updated_at ).to be_a Time
          expect( subscription.canceled_at ).to be_a Time
          expect( subscription.app_id ).to be_nil
          expect( subscription.is_canceled ).to be true
          expect( subscription.is_deleted ).to be false
          expect( subscription.status ).to eq 'inactive'
          expect( subscription.client.email ).to eq client.email
      end
      it 'should remove the given subscription', :vcr do
        subscription = Subscription.create( payment: payment, offer: offer, name: 'To Delete' ).remove

        expect( subscription.id ).to be_a String
        expect( subscription.offer.amount ).to be offer.amount
        expect( subscription.offer.currency ).to eq offer.currency
        expect( subscription.offer.interval ).to eq offer.interval
        expect( subscription.offer.name ).to eq offer.name
        expect( subscription.livemode ).to be false
        expect( subscription.amount ).to be offer.amount
        expect( subscription.temp_amount ).to be_nil
        expect( subscription.currency ).to eq offer.currency
        expect( subscription.name ).to eq 'To Delete'
        expect( subscription.interval ).to eq offer.interval
        expect( subscription.trial_start ).to be_nil
        expect( subscription.trial_end ).to be_nil
        expect( subscription.period_of_validity ).to be_nil
        expect( subscription.end_of_period ).to be_nil
        expect( subscription.next_capture_at ).to be_nil
        expect( subscription.created_at ).to be_a Time
        expect( subscription.updated_at ).to be_a Time
        expect( subscription.canceled_at ).to be_a Time
        expect( subscription.app_id ).to be_nil
        expect( subscription.is_canceled ).to be true
        expect( subscription.is_deleted ).to be false
        expect( subscription.status ).to eq 'inactive'
        expect( subscription.client.email ).to eq client.email
      end
    end
  end
end
