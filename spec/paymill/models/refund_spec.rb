require 'spec_helper'

module Paymill
  describe Refund do

    let( :currency ) { 'USD' }
    let( :token ) { '098f6bcd4621d373cade4e832627b4f6' }

    refund_id = nil

    context '::create' do
      it 'should refund 1$ from transaction', :vcr do
        amount = Random.rand(200..10000)
        transaction = Transaction.create( token: token, amount: amount, currency: currency )

        refund = Refund.create( transaction, amount: 100 )
        refund_id = refund.id

        expect( refund.id ).to be_a String
        expect( refund.amount ).to be 100
        expect( refund.status ).to eq 'refunded'
        expect( refund.description ).to be_nil
        expect( refund.livemode ).to be false
        expect( refund.created_at ).to be_a Time
        expect( refund.updated_at ).to be_a Time
        expect( refund.response_code ).to be 20000
        expect( refund.transaction.id ).to eq transaction.id
        expect( refund.transaction.amount ).to eq( transaction.origin_amount - 100 )
        expect( refund.app_id ).to be_nil
      end

      it 'should refund 1$ from transaction with description', :vcr do
        amount = Random.rand(200..10000)
        transaction = Transaction.create( token: token, amount: amount, currency: currency )

        refund = Refund.create( transaction, amount: 100, description: 'Refunded By Ruby' )
        expect( refund.id ).to be_a String
        expect( refund.amount ).to be 100
        expect( refund.status ).to eq 'refunded'
        expect( refund.description ).to eq 'Refunded By Ruby'
        expect( refund.livemode ).to be false
        expect( refund.created_at ).to be_a Time
        expect( refund.updated_at ).to be_a Time
        expect( refund.response_code ).to be 20000
        expect( refund.transaction.id ).to eq transaction.id
        expect( refund.transaction.amount ).to eq( transaction.origin_amount - 100 )
        expect( refund.app_id ).to be_nil
      end

      it 'should throw ArgumentError when no amount given', :vcr do
        expect{ Refund.create( Transaction.create( token: token, amount: 290, currency: currency ) ) }.to raise_error ArgumentError
      end

      it 'should throw ArgumentError when no transaction given', :vcr do
        expect{ Refund.create( amount: 999 ) }.to raise_error ArgumentError
      end
    end

    context '::find' do
      it 'should find existing refund' do
        refund = Refund.find( refund_id )

        expect( refund.id ).to be_a String
        expect( refund.amount ).to be 100
        expect( refund.status ).to eq 'refunded'
        expect( refund.description ).to be_nil
        expect( refund.livemode ).to be false
        expect( refund.created_at ).to be_a Time
        expect( refund.updated_at ).to be_a Time
        expect( refund.response_code ).to be 20000
        expect( refund.transaction ).not_to be_nil
        expect( refund.app_id ).to be_nil
      end

      it 'should raise PaymillError when invalid id given' do
        expect{ Refund.find( 'fake_id' ) }.to raise_error PaymillError
      end
    end
  end
end
