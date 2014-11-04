require 'spec_helper'

module Paymill
  describe Transaction do

    let( :amount ) { 2990 }
    let( :currency ) { 'USD' }
    let( :token ) { '098f6bcd4621d373cade4e832627b4f6' }
    let( :client ) { Client.create( email: 'rocky.balboa@qaiware.com' ) }
    let( :payment ) { Payment.create( token: token, client: client ) }
    let( :preauth ) { Preauthorization.create( payment: payment, amount: amount, currency: currency, description: 'The Italian Stallion' ) }

    transaction_id = nil

    context '::create' do
      it 'should create transaction with token', :vcr do
        transaction = Transaction.create( token: token, amount: amount, currency: currency )
        transaction_id = transaction.id

        expect( transaction ).to be_a Transaction

        expect( transaction.id ).to be_a String
        expect( transaction.amount ).to be amount
        expect( transaction.origin_amount ).to be amount
        expect( transaction.status ).to eq 'closed'
        expect( transaction.description ).to be_nil
        expect( transaction.livemode ).to be false
        expect( transaction.refunds ).to be_nil
        expect( transaction.currency ).to eq currency
        expect( transaction.created_at ).to be_a Time
        expect( transaction.updated_at ).to be_a Time
        expect( transaction.response_code ).to be 20000
        expect( transaction.is_fraud ).to be false
        expect( transaction.short_id ).to eq '7357.7357.7357'
        expect( transaction.fees ).to be_empty
        expect( transaction.invoices ).to be_empty
        expect( transaction.payment ).to be_a Payment
        expect( transaction.client ).to be_a Client
        expect( transaction.preauthorization ).to be_nil
        expect( transaction.app_id ).to be_nil
      end

      it 'should create transaction with token and description', :vcr do
        transaction = Transaction.create( token: token, amount: amount, currency: currency, description: 'The Italian Stallion' )

        expect( transaction ).to be_a Transaction

        expect( transaction.id ).to be_a String
        expect( transaction.amount ).to be amount
        expect( transaction.origin_amount ).to be amount
        expect( transaction.status ).to eq 'closed'
        expect( transaction.description ).to eq 'The Italian Stallion'
        expect( transaction.livemode ).to be false
        expect( transaction.refunds ).to be_nil
        expect( transaction.currency ).to eq currency
        expect( transaction.created_at ).to be_a Time
        expect( transaction.updated_at ).to be_a Time
        expect( transaction.response_code ).to be 20000
        expect( transaction.is_fraud ).to be false
        expect( transaction.short_id ).to eq '7357.7357.7357'
        expect( transaction.fees ).to be_empty
        expect( transaction.invoices ).to be_empty
        expect( transaction.payment ).to be_a Payment
        expect( transaction.client ).to be_a Client
        expect( transaction.preauthorization ).to be_nil
        expect( transaction.app_id ).to be_nil
      end

      it 'should create transaction with payment', :vcr do
        transaction = Transaction.create( payment: payment, amount: amount, currency: currency )

        expect( transaction ).to be_a Transaction

        expect( transaction.id ).to be_a String
        expect( transaction.amount ).to be amount
        expect( transaction.origin_amount ).to be amount
        expect( transaction.status ).to eq 'closed'
        expect( transaction.description ).to be_nil
        expect( transaction.livemode ).to be false
        expect( transaction.refunds ).to be_nil
        expect( transaction.currency ).to eq currency
        expect( transaction.created_at ).to be_a Time
        expect( transaction.updated_at ).to be_a Time
        expect( transaction.response_code ).to be 20000
        expect( transaction.is_fraud ).to be false
        expect( transaction.short_id ).to eq '7357.7357.7357'
        expect( transaction.fees ).to be_empty
        expect( transaction.invoices ).to be_empty
        expect( transaction.payment.id ).to eq payment.id
        expect( transaction.client.id ).to eq client.id
        expect( transaction.client.email ).to eq 'rocky.balboa@qaiware.com'
        expect( transaction.app_id ).to be_nil

        expect( transaction.preauthorization ).to be_nil
      end

      it 'should create transaction with preauthorization', :vcr do
        transaction = Transaction.create( preauthorization: preauth, amount: amount, currency: currency )

        expect( transaction ).to be_a Transaction

        expect( transaction.id ).to be_a String
        expect( transaction.amount ).to be amount
        expect( transaction.origin_amount ).to be amount
        expect( transaction.status ).to eq 'closed'
        expect( transaction.description ).to be_nil
        expect( transaction.livemode ).to be false
        expect( transaction.refunds ).to be_nil
        expect( transaction.currency ).to eq currency
        expect( transaction.created_at ).to be_a Time
        expect( transaction.updated_at ).to be_a Time
        expect( transaction.response_code ).to be 20000
        expect( transaction.is_fraud ).to be false
        expect( transaction.short_id ).to eq '7357.7357.7357'
        expect( transaction.fees ).to be_empty
        expect( transaction.invoices ).to be_empty
        expect( transaction.payment.id ).to eq payment.id
        expect( transaction.client.id ).to eq client.id
        expect( transaction.client.email ).to eq 'rocky.balboa@qaiware.com'
        expect( transaction.app_id ).to be_nil

        expect( transaction.preauthorization.id ).to eq preauth.id
      end

      it 'should create transaction with client and payment', :vcr do
        transaction = Transaction.create( payment: payment, amount: amount, currency: currency, client: client )

        expect( transaction ).to be_a Transaction

        expect( transaction.id ).to be_a String
        expect( transaction.amount ).to be amount
        expect( transaction.origin_amount ).to be amount
        expect( transaction.status ).to eq 'closed'
        expect( transaction.description ).to be_nil
        expect( transaction.livemode ).to be false
        expect( transaction.refunds ).to be_nil
        expect( transaction.currency ).to eq currency
        expect( transaction.created_at ).to be_a Time
        expect( transaction.updated_at ).to be_a Time
        expect( transaction.response_code ).to be 20000
        expect( transaction.is_fraud ).to be false
        expect( transaction.short_id ).to eq '7357.7357.7357'
        expect( transaction.fees ).to be_empty
        expect( transaction.invoices ).to be_empty
        expect( transaction.payment.id ).to eq payment.id
        expect( transaction.client.id ).to eq client.id
        expect( transaction.client.email ).to eq 'rocky.balboa@qaiware.com'
        expect( transaction.app_id ).to be_nil

        expect( transaction.preauthorization ).to be_nil
      end

      it 'should throw PaymillError with payment and different client', :vcr do
        expect{ Transaction.create( payment: payment, amount: amount, currency: currency, client: Client.create() ) }.to raise_error PaymillError
      end

      it 'should throw ArgumentError when creating with token and payment', :vcr do
        expect{ Transaction.create( token: token, payment: payment, currency: currency, amount: amount ) }.to raise_error ArgumentError
      end

      it 'should throw ArgumentError when creating with token and payment and preauthorization', :vcr do
        expect{ Transaction.create( token: token, payment: payment, preauthorization: preauth, currency: currency, amount: amount ) }.to raise_error ArgumentError
      end
    end

    context '::find' do
      it 'should find transaction by valid id', :vcr do
        expect( Transaction.find( transaction_id ).id ).to eq transaction_id
      end

      it 'should throw PaymillError when unvalid id given', :vcr do
        expect{ Transaction.find( 'fake_id' ) }.to raise_error PaymillError
      end
    end

    context '::update' do
      it 'should update existing transaction description', :vcr do
        transaction =  Transaction.find( transaction_id )

        transaction.description = 'The Italian Stallion'
        transaction = Transaction.update( transaction )

        expect( transaction ).to be_a Transaction

        expect( transaction.id ).to be_a String
        expect( transaction.amount ).to be amount
        expect( transaction.origin_amount ).to be amount
        expect( transaction.status ).to eq 'closed'
        expect( transaction.description ).to eq 'The Italian Stallion'
        expect( transaction.livemode ).to be false
        expect( transaction.refunds ).to be_nil
        expect( transaction.currency ).to eq currency
        expect( transaction.created_at ).to be_a Time
        expect( transaction.updated_at ).to be_a Time
        expect( transaction.response_code ).to be 20000
        expect( transaction.is_fraud ).to be false
        expect( transaction.short_id ).to eq '7357.7357.7357'
        expect( transaction.fees ).to be_empty
        expect( transaction.invoices ).to be_empty
        expect( transaction.payment ).to be_a Payment
        expect( transaction.client ).to be_a Client
        expect( transaction.preauthorization ).to be_nil
        expect( transaction.app_id ).to be_nil

      end

      it "should throw NoMethodError when by updating transaction's amount", :vcr do
        transaction =  Transaction.find( transaction_id )

        expect{ transaction.amount = 999 }.to raise_error NoMethodError
      end
    end

  end
end
