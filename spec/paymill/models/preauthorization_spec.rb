require 'spec_helper'

module Paymill
  describe Preauthorization do

    let( :amount ) { 1990 }
    let( :client ) { Client.create( email: 'rocky.balboa@qaiware.com' ) }
    let( :currency ) { 'USD' }
    let( :payment ) { Payment.create( token: '098f6bcd4621d373cade4e832627b4f6', client: client.id ) }
    let( :token ) { '098f6bcd4621d373cade4e832627b4f6' }

    preauthorization_id = nil

    context '::create' do
      it 'should create preauthorization with token', :vcr do
        preauthorization = Preauthorization.create( token: token, amount: amount, currency: currency )
        preauthorization_id = preauthorization.id

        expect( preauthorization ).to be_a Preauthorization

        expect( preauthorization.id ).to be_a String
        expect( preauthorization.amount ).to be amount
        expect( preauthorization.currency ).to eq currency
        expect( preauthorization.description ).to be_nil
        expect( preauthorization.status ).to eq 'closed'
        expect( preauthorization.livemode ).to be false
        expect( preauthorization.created_at ).to be_a Time
        expect( preauthorization.updated_at ).to be_a Time
        expect( preauthorization.app_id ).to be_nil

        expect( preauthorization.payment ).to be_a Payment
        expect( preauthorization.payment.type ).to eq 'creditcard'
        expect( preauthorization.payment.client ).to be_a String
        expect( preauthorization.payment.card_type ). to eq 'visa'

        expect( preauthorization.payment.country ).to be_nil
        expect( preauthorization.payment.expire_month ).to eq 12
        expect( preauthorization.payment.expire_year ).to eq 2015
        expect( preauthorization.payment.card_holder ).to be_empty
        expect( preauthorization.payment.last4 ).to eq 1111
        expect( preauthorization.payment.is_recurring ).to be true
        expect( preauthorization.payment.is_usable_for_preauthorization ).to be true

        expect( preauthorization.payment.id ).to be_a String
        expect( preauthorization.payment.created_at ).to be_a Time
        expect( preauthorization.payment.updated_at ).to be_a Time
        expect( preauthorization.payment.app_id ).to be_nil

        expect( preauthorization.client ).to be_a Client

        # expect( preauthorization.transaction ).to <Obejct>"
      end

      it 'should create preauthorization with payment', :vcr do
        preauthorization = Preauthorization.create( payment: payment.id, amount: amount, currency: currency )
        preauthorization_id = preauthorization.id

        expect( preauthorization ).to be_a Preauthorization

        expect( preauthorization.id ).to be_a String
        expect( preauthorization.amount ).to be amount
        expect( preauthorization.currency ).to eq currency
        expect( preauthorization.description ).to be_nil
        expect( preauthorization.status ).to eq 'closed'
        expect( preauthorization.livemode ).to be false
        expect( preauthorization.created_at ).to be_a Time
        expect( preauthorization.updated_at ).to be_a Time
        expect( preauthorization.app_id ).to be_nil

        expect( preauthorization.payment ).to be_a Payment
        expect( preauthorization.payment.id ).to eq payment.id
        expect( preauthorization.payment.type ).to eq 'creditcard'
        expect( preauthorization.payment.client ).to eq client.id
        expect( preauthorization.payment.card_type ). to eq 'visa'

        expect( preauthorization.payment.country ).to be_nil
        expect( preauthorization.payment.expire_month ).to eq 12
        expect( preauthorization.payment.expire_year ).to eq 2015
        expect( preauthorization.payment.card_holder ).to be_empty
        expect( preauthorization.payment.last4 ).to eq 1111
        expect( preauthorization.payment.is_recurring ).to be true
        expect( preauthorization.payment.is_usable_for_preauthorization ).to be true

        expect( preauthorization.payment.id ).to be_a String
        expect( preauthorization.payment.created_at ).to be_a Time
        expect( preauthorization.payment.updated_at ).to be_a Time
        expect( preauthorization.payment.app_id ).to be_nil

        expect( preauthorization.client ).to be_a Client
        expect( preauthorization.client.id ).to eq client.id
        expect( preauthorization.client.email ).to eq 'rocky.balboa@qaiware.com'

        # expect( preauthorization.transaction ).to <Obejct>"
      end

      it 'should create preauthorization with payment and description', :vcr do
        preauthorization = Preauthorization.create( payment: payment, amount: amount, currency: currency, description: 'The Italian Stallion' )
        preauthorization_id = preauthorization.id

        expect( preauthorization ).to be_a Preauthorization

        expect( preauthorization.id ).to be_a String
        expect( preauthorization.amount ).to be amount
        expect( preauthorization.currency ).to eq currency
        expect( preauthorization.description ).to eq 'The Italian Stallion'
        expect( preauthorization.status ).to eq 'closed'
        expect( preauthorization.livemode ).to be false
        expect( preauthorization.created_at ).to be_a Time
        expect( preauthorization.updated_at ).to be_a Time
        expect( preauthorization.app_id ).to be_nil

        expect( preauthorization.payment ).to be_a Payment
        expect( preauthorization.payment.id ).to eq payment.id
        expect( preauthorization.payment.type ).to eq 'creditcard'
        expect( preauthorization.payment.client ).to eq client.id
        expect( preauthorization.payment.card_type ). to eq 'visa'

        expect( preauthorization.payment.country ).to be_nil
        expect( preauthorization.payment.expire_month ).to eq 12
        expect( preauthorization.payment.expire_year ).to eq 2015
        expect( preauthorization.payment.card_holder ).to be_empty
        expect( preauthorization.payment.last4 ).to eq 1111
        expect( preauthorization.payment.is_recurring ).to be true
        expect( preauthorization.payment.is_usable_for_preauthorization ).to be true

        expect( preauthorization.payment.id ).to be_a String
        expect( preauthorization.payment.created_at ).to be_a Time
        expect( preauthorization.payment.updated_at ).to be_a Time
        expect( preauthorization.payment.app_id ).to be_nil

        expect( preauthorization.client ).to be_a Client
        expect( preauthorization.client.id ).to eq client.id
        expect( preauthorization.client.email ).to eq 'rocky.balboa@qaiware.com'

        # expect( preauthorization.transaction ).to <Obejct>"
      end

      it 'should throw ArgumentError when creating without amount', :vcr do
        expect{ Preauthorization.create( payment: payment, currency: currency ) }.to raise_error ArgumentError
      end

      it 'should throw ArgumentError when creating wit invalid argument', :vcr do
        expect{ Preauthorization.create( payment: payment, currency: currency, amount: amount, fake: true ) }.to raise_error ArgumentError
      end

      it 'should throw ArgumentError when creating without token or payment', :vcr do
        expect{ Preauthorization.create( currency: currency, amount: amount ) }.to raise_error ArgumentError
      end

      it 'should throw ArgumentError when creating with token and payment', :vcr do
        expect{ Preauthorization.create( token: token, payment: payment, currency: currency, amount: amount ) }.to raise_error ArgumentError
      end
    end

    context '::find' do
      it 'should find preauthorization by valid id', :vcr do
        expect( Preauthorization.find( preauthorization_id ).id ).to eq preauthorization_id
      end

      it 'should throw PaymillError when unvalid id given', :vcr do
        expect{ Preauthorization.find( 'fake_id' ) }.to raise_error PaymillError
      end
    end

    context '::deltele' do
      it 'should delete existing preauthorization', :vcr do
        expect( Preauthorization.delete( preauthorization_id ) ).to be_nil
      end

      it 'shoold throw error when preauthorization not found', :vcr do
        expect{ Preauthorization.delete( 'fake_id' ) }.to raise_error PaymillError
      end
    end
  end
end
