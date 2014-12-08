require 'spec_helper'

module Paymill
  describe Payment do

    payment_id = nil

    let( :client ) { Client.create( email: 'john.rambo@qaiware.com') }

    context '::find' do
      it 'should find a payment by given valid id', :vcr do
        payment = Payment.find( 'pay_ea98515b29437b046207ea45' )

        expect( payment ).to be_a Payment

        expect( payment.type ).to eq 'creditcard'
        expect( payment.client ).to be_a Client
        expect( payment.card_type ). to eq 'visa'

        expect( payment.country ).to be_nil
        expect( payment.expire_month ).to eq 12
        expect( payment.expire_year ).to eq 2015
        expect( payment.card_holder ).to be_empty
        expect( payment.last4 ).to eq 1111
        expect( payment.is_recurring ).to be true
        expect( payment.is_usable_for_preauthorization ).to be true

        expect( payment.id ).to eq 'pay_ea98515b29437b046207ea45'
        expect( payment.created_at ).to be_a Time
        expect( payment.updated_at ).to be_a Time
        expect( payment.app_id ).to be_nil

        # TODO[VNi]: be more descriptive
      end
      it 'should throw NotFoundError when unexisting payment id given', :vcr do
        expect{ Payment.find( 'fake_id' ) }.to raise_error PaymillError
      end
    end

    context '::create' do
      context 'creditcard' do
        it 'should create client with token', :vcr do
          payment = Payment.create( token: '098f6bcd4621d373cade4e832627b4f6' )
          payment_id = payment.id

          expect( payment ).to be_a Payment

          expect( payment.type ).to eq 'creditcard'
          expect( payment.client ).to be_nil
          expect( payment.card_type ). to eq 'visa'

          expect( payment.country ).to be_nil
          expect( payment.expire_month ).to eq 12
          expect( payment.expire_year ).to eq 2015
          expect( payment.card_holder ).to be_empty
          expect( payment.last4 ).to eq 1111
          expect( payment.is_recurring ).to be true
          expect( payment.is_usable_for_preauthorization ).to be true

          expect( payment.id ).to be_a String
          expect( payment.created_at ).to be_a Time
          expect( payment.updated_at ).to be_a Time
          expect( payment.app_id ).to be_nil
        end

        it 'should create client with token and client', :vcr do
          payment = Payment.create( token: '098f6bcd4621d373cade4e832627b4f6', client: client.id )

          expect( payment ).to be_a Payment

          expect( payment.type ).to eq 'creditcard'
          expect( payment.client ).to be_a Client
          expect( payment.client.id ).to eq client.id
          expect( payment.card_type ). to eq 'visa'

          expect( payment.country ).to be_nil
          expect( payment.expire_month ).to eq 12
          expect( payment.expire_year ).to eq 2015
          expect( payment.card_holder ).to be_empty
          expect( payment.last4 ).to eq 1111
          expect( payment.is_recurring ).to be true
          expect( payment.is_usable_for_preauthorization ).to be true

          expect( payment.id ).to be_a String
          expect( payment.created_at ).to be_a Time
          expect( payment.updated_at ).to be_a Time
          expect( payment.app_id ).to be_nil
        end

        it 'should throw exception when creating a clinent with invalid token', :vcr do
          expect{ Payment.create( token: 'fake' ) }.to raise_error PaymillError
        end

        it 'should throw exception when creating a clinent with invalid client id', :vcr do
          expect{ Payment.create( token: '098f6bcd4621d373cade4e832627b4f6', client: 'fake' ) }.to raise_error PaymillError
        end

        it 'should throw exception when creating wrong argument name', :vcr do
          expect{ Payment.create( foo: 'fake' ) }.to raise_error ArgumentError
        end

        it 'should throw exception when creating more arguments', :vcr do
          expect{ Payment.create( token: '098f6bcd4621d373cade4e832627b4f6', client: client.id, foo: 'fake' ) }.to raise_error ArgumentError
        end

        it 'should throw exception when creating more arguments', :vcr do
          expect{ Payment.create() }.to raise_error ArgumentError
        end
      end
      context 'debit' do
        it 'should create client with token', :vcr do
          payment = Payment.create( token: '12a46bcd462sd3r3care4e8336ssb4f5' )

          expect( payment ).to be_a Payment

          expect( payment.type ).to eq 'debit'
          expect( payment.client ).to be_nil

          expect( payment.code ).to eq 123456789
          expect( payment.holder ).to eq 'Max Mustermann'
          expect( payment.account ).to eq '******2345'
          expect( payment.is_recurring ).to be true
          expect( payment.is_usable_for_preauthorization ).to be true

          expect( payment.id ).to be_a String
          expect( payment.created_at ).to be_a Time
          expect( payment.updated_at ).to be_a Time
          expect( payment.app_id ).to be_nil
        end

        it 'should create client with token and client', :vcr do
          payment = Payment.create( token: '12a46bcd462sd3r3care4e8336ssb4f5', client: client.id )

          expect( payment ).to be_a Payment

          expect( payment.type ).to eq 'debit'
          expect( payment.client ).to be_a Client
          expect( payment.client.id ).to eq client.id

          expect( payment.code ).to eq 123456789
          expect( payment.holder ).to eq 'Max Mustermann'
          expect( payment.account ).to eq '******2345'
          expect( payment.is_recurring ).to be true
          expect( payment.is_usable_for_preauthorization ).to be true

          expect( payment.id ).to be_a String
          expect( payment.created_at ).to be_a Time
          expect( payment.updated_at ).to be_a Time
          expect( payment.app_id ).to be_nil
        end
      end
    end

    context '::delete' do
      it 'showd delete existing payment', :vcr do
        expect( Payment.find( payment_id ).delete ).to be_nil
      end
    end
  end
end
