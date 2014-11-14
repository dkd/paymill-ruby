module Paymill
  class Refund < Base

    attr_reader :amount, :description, :transaction, :status, :livemode, :response_code

    def self.create( transaction, attributes = {} )
      raise ArgumentError unless create_with?( attributes.keys )
      response = Paymill.request( Http.post( name.demodulize.tableize, transaction.id, Restful.normalize( attributes ) ) )
      new( response['data'] )
    end

    protected
    def self.mandatory_arguments
      [:amount]
    end

    def self.allowed_arguments
      [:amount, :description]
    end

  end
end
