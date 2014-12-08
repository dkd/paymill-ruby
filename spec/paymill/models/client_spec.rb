require 'spec_helper'

module Paymill
  describe Client do

    client_id = nil

    context '::find' do
      it 'should throw AuthenticationError when API_KEY is not set', :vcr do
        Paymill.api_key = nil
        expect{ Client.find( 'fake_id' ) }.to raise_error AuthenticationError
        Paymill.api_key = ENV['PAYMILL_API_TEST_KEY']
      end

      it 'should throw NotFoundError when unexisting client id given', :vcr do
        expect{ Client.find( 'fake_id' ) }.to raise_error PaymillError
      end

      it 'should find a Client object when valid client id is given', :vcr do
        client = Client.find( 'client_b54ff8b3811e06c02e14' )

        expect( client ).to be_a Client
        expect( client.id ).to eq 'client_b54ff8b3811e06c02e14'
        expect( client.email ).to eq 'john.rambo@qaiware.com'
        expect( client.description ).to eq 'Boom, boom, shake the room'
        expect( client.created_at ).to be_a Time
        expect( client.updated_at ).to be_a Time
        expect( client.app_id ).to be_nil

        expect( client.payments ).not_to be_nil
        expect( client.payments.first ).to be_a Payment

        expect( client.payments.first.id ).to eq 'pay_ea98515b29437b046207ea45'
        expect( client.payments.first.type ).to eq 'creditcard'
        expect( client.payments.first.client ).to eq 'client_b54ff8b3811e06c02e14'
        expect( client.payments.first.card_type ).to eq 'visa'
        expect( client.payments.first.country ).to be_nil
        expect( client.payments.first.expire_month ).to eq 12
        expect( client.payments.first.expire_year ).to eq 2015
        expect( client.payments.first.card_holder ).to be_empty
        expect( client.payments.first.last4 ).to eq 1111
        expect( client.payments.first.created_at ).to be_a Time
        expect( client.payments.first.updated_at ).to be_a Time
        expect( client.payments.first.app_id ).to be_nil
        expect( client.payments.first.is_recurring ).to be true
        expect( client.payments.first.is_usable_for_preauthorization ).to be true


        expect( client.subscriptions ).not_to be_nil

        expect( client.subscriptions.first ).to be_a Subscription
        expect( client.subscriptions.first.id ).to eq 'sub_5e6e2bbe5176a5271f48'
        expect( client.subscriptions.first.offer.id ).to eq 'offer_fcba97f1f6f9a6af2a4d'
        expect( client.subscriptions.first.offer.name ).to eq 'Chuck Testa'
        expect( client.subscriptions.first.offer.amount ).to be 900
        expect( client.subscriptions.first.offer.currency ).to eq 'EUR'
        expect( client.subscriptions.first.offer.interval ).to eq '1 MONTH'
        expect( client.subscriptions.first.offer.trial_period_days ).to be 0
        expect( client.subscriptions.first.offer.created_at ).to be_a Time
        expect( client.subscriptions.first.offer.updated_at ).to be_a Time
        expect( client.subscriptions.first.offer.subscription_count.active ).to be 0
        expect( client.subscriptions.first.offer.subscription_count.inactive ).to be 1
        expect( client.subscriptions.first.offer.app_id ).to be_nil
        expect( client.subscriptions.first.livemode ).to be false
        expect( client.subscriptions.first.amount ).to be 900
        expect( client.subscriptions.first.temp_amount ).to be_nil
        expect( client.subscriptions.first.currency ).to eq 'EUR'
        expect( client.subscriptions.first.name ).to eq 'Chuck Testa'
        expect( client.subscriptions.first.interval ).to eq '1 MONTH'
        expect( client.subscriptions.first.trial_start ).to be_nil
        expect( client.subscriptions.first.trial_end ).to be_nil
        expect( client.subscriptions.first.period_of_validity ).to be_nil
        expect( client.subscriptions.first.end_of_period ).to be_nil
        expect( client.subscriptions.first.next_capture_at ).to be_nil
        expect( client.subscriptions.first.created_at ).to be_a Time
        expect( client.subscriptions.first.updated_at ).to be_a Time
        expect( client.subscriptions.first.canceled_at ).to be_a Time
        expect( client.subscriptions.first.payment ).to eq 'pay_ea98515b29437b046207ea45'
        expect( client.subscriptions.first.app_id ).to be_nil
        expect( client.subscriptions.first.is_canceled ).to be true
        expect( client.subscriptions.first.is_deleted ).to be false
        expect( client.subscriptions.first.status ).to eq 'inactive'
        expect( client.subscriptions.first.client ).to eq 'client_b54ff8b3811e06c02e14'


        expect( client.subscriptions.last ).to be_a Subscription
        expect( client.subscriptions.last.id ).to eq 'sub_b519112c57579508d188'
        expect( client.subscriptions.last.offer.id ).to eq 'offer_a71865bef8f9425b9740'
        expect( client.subscriptions.last.offer.name ).to eq 'Updated Chuck Testa'
        expect( client.subscriptions.last.offer.amount ).to be 1800
        expect( client.subscriptions.last.offer.currency ).to eq 'EUR'
        expect( client.subscriptions.last.offer.interval ).to eq '1 MONTH'
        expect( client.subscriptions.last.offer.trial_period_days ).to be 0
        expect( client.subscriptions.last.offer.created_at ).to be_a Time
        expect( client.subscriptions.last.offer.updated_at ).to be_a Time
        expect( client.subscriptions.last.offer.subscription_count.active ).to be 0
        expect( client.subscriptions.last.offer.subscription_count.inactive ).to be 1
        expect( client.subscriptions.last.offer.app_id ).to be_nil
        expect( client.subscriptions.last.livemode ).to be false
        expect( client.subscriptions.last.amount ).to be 1800
        expect( client.subscriptions.last.temp_amount ).to be_nil
        expect( client.subscriptions.last.currency ).to eq 'EUR'
        expect( client.subscriptions.last.name ).to eq 'Updated Chuck Testa'
        expect( client.subscriptions.last.interval ).to eq '1 MONTH'
        expect( client.subscriptions.last.trial_start ).to be_nil
        expect( client.subscriptions.last.trial_end ).to be_nil
        expect( client.subscriptions.last.period_of_validity ).to be_nil
        expect( client.subscriptions.last.end_of_period ).to be_nil
        expect( client.subscriptions.last.next_capture_at ).to be_nil
        expect( client.subscriptions.last.created_at ).to be_a Time
        expect( client.subscriptions.last.updated_at ).to be_a Time
        expect( client.subscriptions.last.canceled_at ).to be_a Time
        expect( client.subscriptions.last.payment ).to eq 'pay_ea98515b29437b046207ea45'
        expect( client.subscriptions.last.app_id ).to be_nil
        expect( client.subscriptions.last.is_canceled ).to be true
        expect( client.subscriptions.last.is_deleted ).to be false
        expect( client.subscriptions.last.status ).to eq 'inactive'
        expect( client.subscriptions.last.client ).to eq 'client_b54ff8b3811e06c02e14'
      end
    end

    context '::create' do
      it 'should create new client with given email and description', :vcr do
        client = Client.create( email: 'john.rambo@qaiware.com', description: 'Main caracter in First Blood' )
        client_id = client.id

        expect( client ).to be_a Client

        expect( client.email ).to eq 'john.rambo@qaiware.com'
        expect( client.description ).to eq 'Main caracter in First Blood'

        expect( client.id ).to be_a String
        expect( client.created_at ).to be_a Time
        expect( client.updated_at ).to be_a Time
        expect( client.app_id ).to be_nil


        expect( client.payments.size ).to be 0
        expect( client.subscriptions ).to be_nil
      end

      it 'should create new client with given email', :vcr do
        client = Client.create( email: 'john.rambo@qaiware.com' )
        expect( client ).to be_a Client

        expect( client.email ).to eq 'john.rambo@qaiware.com'
        expect( client.description ).to be_nil

        expect( client.id ).to be_a String
        expect( client.created_at ).to be_a Time
        expect( client.updated_at ).to be_a Time
        expect( client.app_id ).to be_nil


        expect( client.payments.size ).to be 0
        expect( client.subscriptions ).to be_nil
      end

      it 'should create new client with given description', :vcr do
        client = Client.create( description: 'Main caracter in First Blood' )
        expect( client ).to be_a Client

        expect( client.email ).to be_nil
        expect( client.description ).to eq 'Main caracter in First Blood'

        expect( client.id ).to be_a String
        expect( client.created_at ).to be_a Time
        expect( client.updated_at ).to be_a Time
        expect( client.app_id ).to be_nil

        expect( client.payments.size ).to be 0
        expect( client.subscriptions ).to be_nil
      end

      it 'should create new client with no arguments', :vcr do
        client = Client.create()
        expect( client ).to be_a Client

        expect( client.email ).to be_nil
        expect( client.description ).to be_nil

        expect( client.id ).to be_a String
        expect( client.created_at ).to be_a Time
        expect( client.updated_at ).to be_a Time
        expect( client.app_id ).to be_nil

        expect( client.payments.size ).to be 0
        expect( client.subscriptions ).to be_nil
      end

      it 'should throw ArgumentError when creating with invalid argument', :vcr do
        expect{ Client.create( foo: 'foo' ) }.to raise_error ArgumentError
      end
    end

    context '::update' do
      it "should update client's email and description", :vcr do
        client = Client.find( client_id )
        created_at = client.created_at

        client.email = 'john.ruby.rambo@qaiware.com'
        client.description = 'Main Ruby caracter in First Blood'

        client.update

        expect( client ).to be_a Client
        expect( client.email ).to eq 'john.ruby.rambo@qaiware.com'
        expect( client.description ).to eq 'Main Ruby caracter in First Blood'
        expect( client.id ).to be_a String
        expect( client.created_at ).to eq created_at
        expect( client.created_at ).to be < client.updated_at
        expect( client.app_id ).to be_nil
        expect( client.payments.size ).to be 0
        expect( client.subscriptions ).to be_nil
      end

      it "should update client's email", :vcr do
        client = Client.find( client_id )
        created_at = client.created_at

        client.email = 'john.rambo@qaiware.com'

        client.update

        expect( client ).to be_a Client
        expect( client.email ).to eq 'john.rambo@qaiware.com'
        expect( client.description ).to eq 'Main Ruby caracter in First Blood'
        expect( client.id ).to be_a String
        expect( client.created_at ).to eq created_at
        expect( client.created_at ).to be < client.updated_at
        expect( client.app_id ).to be_nil
        expect( client.payments.size ).to be 0
        expect( client.subscriptions ).to be_nil
      end

      it "should update client's description", :vcr do
        client = Client.find( client_id )
        created_at = client.created_at

        client.description = 'Main caracter in First Blood'

        client.update

        expect( client ).to be_a Client
        expect( client.email ).to eq 'john.rambo@qaiware.com'
        expect( client.description ).to eq 'Main caracter in First Blood'
        expect( client.id ).to be_a String
        expect( client.created_at ).to eq created_at
        expect( client.created_at ).to be < client.updated_at
        expect( client.app_id ).to be_nil
        expect( client.payments.size ).to be 0
        expect( client.subscriptions ).to be_nil
      end

      it "should throw NoMethodError when updating unupdateable field", :vcr do
        client = Client.find( client_id )
        expect{ client.app_id = 'fake_app_id' }.to raise_error NoMethodError
      end
    end

    context '::delete' do
      it 'should delete existing client', :vcr do
        client = Client.find( client_id )
        expect( client.delete() ).to be_nil
      end
    end

    context '::all' do
      it 'should get all clients', :vcr do
        clients = Client.all

        expect( clients ).to be_a Array
        expect( clients ).to respond_to :data_count
      end

      it 'should get all clients with sorting and filters', :vcr do
        # 2014-11-12 23:38:00 to 2014-11-13 23:38:00
        clients = Client.all( order: [:email_asc], filters: [created_at: "1415828227-1415914686"] )

        expect( clients ).to be_a Array
        expect( clients ).to respond_to :data_count
        expect( clients.size ).to be 20
      end

      it 'should get all clients with filters', :vcr do
        clients = Client.all( filters: [email: 'john.rambo@qaiware.com', description: 'Boom, boom, shake the room'] )

        expect( clients ).to be_a Array
        expect( clients ).to respond_to :data_count
        expect( clients.size ).to be 20
      end

      it 'should get all clients with order and count', :vcr do
        clients = Client.all( order: [:email, :created_at_desc], count: 30 )

        expect( clients ).to be_a Array
        expect( clients ).to respond_to :data_count
        expect( clients.size ).to be 30
      end

      it 'should get all clients with order, count and offset', :vcr do
        clients = Client.all( order: [:email, :created_at_desc], count: 30, offset: 10 )

        expect( clients ).to be_a Array
        expect( clients ).to respond_to :data_count
        expect( clients.size ).to be 30
      end

    end
  end
end
