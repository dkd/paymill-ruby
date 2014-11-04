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
      it 'should creaate subscription from offer', :vcr do
        subscription = Subscription.create( offer: offer, payment: payment, client: client )
        subscription_id = subscription.id

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

      it 'should creaate subscription without offer', :vcr do
        subscription = Subscription.create( payment: payment, client: client, amount: amount, currency: currency, interval: interval )
        subscription_id = subscription.id

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

      it 'should creaate subscription without offer and new payment', :vcr do
        subscription = Subscription.create( payment: Payment.create( token: token), amount: amount, currency: currency, interval: interval )
        subscription_id = subscription.id

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

      xit 'should creaate subscription without offer with client and new payment', :vcr do
        subscription = Subscription.create( payment: Payment.create( token: token), client: client, amount: amount, currency: currency, interval: interval )
        subscription_id = subscription.id

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

      it 'should creaate subscription without offer with name and period_of_validity and start_at', :vcr do
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

    end
  end
end
