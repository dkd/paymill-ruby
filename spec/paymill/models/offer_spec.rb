require 'spec_helper'

module Paymill
  describe Offer do

    offer_id = nil

    context '::find' do
      it 'should find a Offer object when valid offer id is given', :vcr do
        offer = Offer.find( 'offer_fcba97f1f6f9a6af2a4d' )

        expect( offer.id ).to eq 'offer_fcba97f1f6f9a6af2a4d'
        expect( offer.name ).to eq 'Chuck Testa'
        expect( offer.amount ).to be 900
        expect( offer.currency ).to eq 'EUR'
        expect( offer.interval ).to eq '1 MONTH'
        expect( offer.trial_period_days ).to be 0
        expect( offer.created_at ).to be_a Time
        expect( offer.updated_at ).to be_a Time
        expect( offer.subscription_count.active ).to be 0
        expect( offer.subscription_count.inactive ).to be 1
        expect( offer.app_id ).to be_nil
      end

      it 'should throw NotFoundError when unexisting offer id given', :vcr do
        expect{ Offer.find( 'fake_id' ) }.to raise_error PaymillError
      end
    end

    context '::create' do
      it 'should create new offer without trial period in days', :vcr do
        offer = Offer.create( amount: 4200, currency: 'EUR', interval: '1 MONTH', name: 'Superabo' )

        expect( offer.id ).to be_a String
        expect( offer.name ).to eq 'Superabo'
        expect( offer.amount ).to be 4200
        expect( offer.currency ).to eq 'EUR'
        expect( offer.interval ).to eq '1 MONTH'
        expect( offer.trial_period_days ).to be 0
        expect( offer.created_at ).to be_a Time
        expect( offer.updated_at ).to be_a Time
        expect( offer.subscription_count.active ).to be 0
        expect( offer.subscription_count.inactive ).to eq 0
        expect( offer.app_id ).to be_nil
      end

      it 'should create new offer with trial period in days', :vcr do
        offer = Offer.create( amount: 4200, currency: 'EUR', interval: '1 MONTH', name: 'sabo', trial_period_days: 30 )
        offer_id = offer.id

        expect( offer.id ).to be_a String
        expect( offer.name ).to eq 'sabo'
        expect( offer.amount ).to eq 4200
        expect( offer.currency ).to eq 'EUR'
        expect( offer.interval ).to eq '1 MONTH'
        expect( offer.trial_period_days ).to be 30
        expect( offer.created_at ).to be_a Time
        expect( offer.updated_at ).to be_a Time
        expect( offer.subscription_count.active ).to be 0
        expect( offer.subscription_count.inactive ).to eq 0
        expect( offer.app_id ).to be_nil
      end

      it 'should throw ArgumentError when creating with invalid argument name', :vcr do
        expect{ Offer.create( foo: '4200', amount: 333, currency: 'EUR', interval: '1 MONTH', name: 'Superabo' ) }.to raise_error ArgumentError
      end

      it 'should throw ArgumentError when creating without amount argument', :vcr do
        expect{ Offer.create( currency: 'EUR', interval: '1 MONTH', name: 'Superabo' ) }.to raise_error ArgumentError
      end

      it 'should throw PaymillError when creating with wrong currency argument value', :vcr do
        expect{ Offer.create( amount: 333, currency: 'ER', interval: '1 MONTH', name: 'Superabo' ) }.to raise_error PaymillError
      end
    end

    context '::update' do
      it "should update offer's name", :vcr do
        offer = Offer.find( offer_id )
        created_at = offer.created_at
        updated_at = offer.updated_at

        offer.name = 'Superabo'
        offer.update

        expect( offer.id ).to eq offer_id
        expect( offer.name ).to eq 'Superabo'
        expect( offer.amount ).to eq 4200
        expect( offer.currency ).to eq 'EUR'
        expect( offer.interval ).to eq '1 MONTH'
        expect( offer.trial_period_days ).to be 30
        expect( offer.created_at ).to eq created_at
        expect( offer.created_at ).to be < offer.updated_at
      end

      it "should update offer's amount and currency", :vcr do
        offer = Offer.find( offer_id )
        created_at = offer.created_at
        updated_at = offer.updated_at

        offer.currency = 'USD'
        offer.amount = '900'
        offer.update

        expect( offer.id ).to eq offer_id
        expect( offer.name ).to eq 'Superabo'
        expect( offer.amount ).to eq 900
        expect( offer.currency ).to eq 'USD'
        expect( offer.interval ).to eq '1 MONTH'
        expect( offer.trial_period_days ).to be 30
        expect( offer.created_at ).to eq created_at
        expect( offer.created_at ).to be < offer.updated_at
      end

      it 'should update offer and its subscriptions', :vcr do
        offer = Offer.find( offer_id )
        created_at = offer.created_at
        updated_at = offer.updated_at

        offer.amount = '1000'
        offer.update( update_subscriptions: true )

        expect( offer.id ).to eq offer_id
        expect( offer.name ).to eq 'Superabo'
        expect( offer.amount ).to eq 1000
        expect( offer.currency ).to eq 'USD'
        expect( offer.interval ).to eq '1 MONTH'
        expect( offer.trial_period_days ).to be 30
        expect( offer.created_at ).to eq created_at
        expect( offer.created_at ).to be < offer.updated_at
      end

      it "should throw NoMethodError when updating unupdateable field", :vcr do
        offer = Offer.find( offer_id )
        expect{ offer.app_id = 'fake_app_id' }.to raise_error NoMethodError
      end
    end

    context '::delete' do
      it 'should delete existing offer', :vcr do
        offer = Offer.find( offer_id )
        expect( offer.delete( remove_with_subscriptions: false ) ).to be_nil
      end

      it 'should delete existing offer with its correlated subscriptions', :vcr do
        offer = Offer.create( amount: 4200, currency: 'EUR', interval: '1 MONTH', name: 'Superabo' )
        expect( offer.delete( remove_with_subscriptions: true ) ).to be_nil
      end
    end
  end
end
