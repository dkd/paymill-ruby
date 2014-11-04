require 'spec_helper'

module Paymill
  describe Webhook do

    active_webhook_id = nil
    inactive_webhook_id = nil

    context '::create' do
      it 'should create url hook', :vcr do
        webhook = Webhook.create( url: 'http://example.com', event_types: ['transaction.succeeded', 'transaction.failed'] )
        active_webhook_id = webhook.id

        expect( webhook.id ).to be_a String
        expect( webhook.url ).to eq 'http://example.com'
        expect( webhook.livemode ).to be false
        expect( webhook.event_types ).to eq ['transaction.succeeded', 'transaction.failed']
        expect( webhook.created_at ).to be_a Time
        expect( webhook.updated_at ).to be_a Time
        expect( webhook.active ).to be true
        expect( webhook.app_id ).to be nil
      end

      it 'should create inactivated email hook', :vcr do
        webhook = Webhook.create( email: 'rambo@qaiware.com', event_types: ['transaction.succeeded', 'transaction.failed'], active: false )
        inactive_webhook_id = webhook.id

        expect( webhook.id ).to be_a String
        expect( webhook.email ).to eq 'rambo@qaiware.com'
        expect( webhook.livemode ).to be false
        expect( webhook.event_types ).to eq ['transaction.succeeded', 'transaction.failed']
        expect( webhook.created_at ).to be_a Time
        expect( webhook.updated_at ).to be_a Time
        expect( webhook.active ).to be false
        expect( webhook.app_id ).to be nil
      end

      it 'should throw ArgumentError when creating without event types', :vcr do
        expect{ Webhook.create( email: 'rambo@qaiware.com' ) }.to raise_error ArgumentError
      end

      it 'should throw ArgumentError when creating wit invalid argument', :vcr do
        expect{ Webhook.create( email: 'rambo@qaiware.com', event_types: ['transaction.succeeded'], fake: true ) }.to raise_error ArgumentError
      end

      it 'should throw ArgumentError when creating without email or url', :vcr do
        expect{ Webhook.create( event_types: ['transaction.succeeded', 'transaction.failed'] ) }.to raise_error ArgumentError
      end

    end

    context '::find' do
      it 'should find webhook by valid id', :vcr do
        webhook = Webhook.find( active_webhook_id )

        expect( webhook.id ).to eq active_webhook_id
        expect( webhook.url ).to eq 'http://example.com'
        expect( webhook.livemode ).to be false
        expect( webhook.event_types ).to eq ['transaction.succeeded', 'transaction.failed']
        expect( webhook.created_at ).to be_a Time
        expect( webhook.updated_at ).to be_a Time
        expect( webhook.active ).to be true
        expect( webhook.app_id ).to be nil
      end

      it 'should throw PaymillError when unvalid id given', :vcr do
        expect{ Webhook.find( 'fake_id' ) }.to raise_error PaymillError
      end
    end

    context '::update' do
      it 'should update type from url to email', :vcr do
        webhook = Webhook.find( active_webhook_id )
        webhook.email = 'rambo@qaiware.com'

        webhook = Webhook.update( webhook )

        expect( webhook.id ).to eq active_webhook_id
        expect( webhook.email ).to eq 'rambo@qaiware.com'
        expect( webhook.url ).to be_nil
        expect( webhook.livemode ).to be false
        expect( webhook.event_types ).to eq ['transaction.succeeded', 'transaction.failed']
        expect( webhook.created_at ).to be_a Time
        expect( webhook.updated_at ).to be_a Time
        expect( webhook.active ).to be true
        expect( webhook.app_id ).to be nil
      end

      it 'should update type from email to url', :vcr do
        webhook = Webhook.find( active_webhook_id )
        webhook.url = 'http://example.com'

        webhook = Webhook.update( webhook )

        expect( webhook.id ).to eq active_webhook_id
        expect( webhook.email ).to be_nil
        expect( webhook.url ).to eq 'http://example.com'
        expect( webhook.livemode ).to be false
        expect( webhook.event_types ).to eq ['transaction.succeeded', 'transaction.failed']
        expect( webhook.created_at ).to be_a Time
        expect( webhook.updated_at ).to be_a Time
        expect( webhook.active ).to be true
        expect( webhook.app_id ).to be nil
      end

      it 'should add one event type', :vcr do
        webhook = Webhook.find( active_webhook_id )
        webhook.event_types << 'transaction.created'

        webhook = Webhook.update( webhook )

        expect( webhook.id ).to eq active_webhook_id
        expect( webhook.email ).to be_nil
        expect( webhook.url ).to eq 'http://example.com'
        expect( webhook.livemode ).to be false
        expect( webhook.event_types ).to eq ['transaction.succeeded', 'transaction.failed', 'transaction.created']
        expect( webhook.created_at ).to be_a Time
        expect( webhook.updated_at ).to be_a Time
        expect( webhook.active ).to be true
        expect( webhook.app_id ).to be nil
      end

      it 'should delete one event type', :vcr do
        webhook = Webhook.find( active_webhook_id )
        webhook.event_types.delete 'transaction.created'

        webhook = Webhook.update( webhook )

        expect( webhook.id ).to eq active_webhook_id
        expect( webhook.email ).to be_nil
        expect( webhook.url ).to eq 'http://example.com'
        expect( webhook.livemode ).to be false
        expect( webhook.event_types ).to eq ['transaction.succeeded', 'transaction.failed']
        expect( webhook.created_at ).to be_a Time
        expect( webhook.updated_at ).to be_a Time
        expect( webhook.active ).to be true
        expect( webhook.app_id ).to be nil
      end

      xit 'should deactivate the webhook', :vcr do
        webhook = Webhook.find( active_webhook_id )
        webhook.active = false

        webhook = Webhook.update( webhook )

        expect( webhook.id ).to eq active_webhook_id
        expect( webhook.email ).to be_nil
        expect( webhook.url ).to eq 'http://example.com'
        expect( webhook.livemode ).to be false
        expect( webhook.event_types ).to eq ['transaction.succeeded', 'transaction.failed']
        expect( webhook.created_at ).to be_a Time
        expect( webhook.updated_at ).to be_a Time
        expect( webhook.active ).to be false
        expect( webhook.app_id ).to be nil
      end

      it 'should activate the webhook', :vcr do
        webhook = Webhook.find( inactive_webhook_id )
        webhook.active = true

        webhook = Webhook.update( webhook )

        expect( webhook.id ).to eq inactive_webhook_id
        expect( webhook.email ).to eq 'rambo@qaiware.com'
        expect( webhook.url ).to be_nil
        expect( webhook.livemode ).to be false
        expect( webhook.event_types ).to eq ['transaction.succeeded', 'transaction.failed']
        expect( webhook.created_at ).to be_a Time
        expect( webhook.updated_at ).to be_a Time
        expect( webhook.active ).to be true
        expect( webhook.app_id ).to be nil
      end

      context '::deltele' do
        it 'showd delete existing webhook', :vcr do
          expect( Webhook.delete( active_webhook_id ) ).to be_nil
        end

        it 'showd throw error when webhook not found', :vcr do
          expect{ Webhook.delete( 'fake_id' ) }.to raise_error PaymillError
        end
      end

    end
  end
end
