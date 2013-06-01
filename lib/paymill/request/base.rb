require_relative 'connection'
require_relative 'validator'

module Paymill
  module Request
    class Base
      def initialize(info)
        @info = info
        @connection = Connection.new(@info)
        @validator = Validator.new(@info)
      end

      def send
        raise AuthenticationError if Paymill.api_key.nil?
        @connection.setup_https
        send_request
        return @validator.validated_data_for(@response)
      end

      private
      def send_request
        @response = @connection.request
      end
    end
  end
end
