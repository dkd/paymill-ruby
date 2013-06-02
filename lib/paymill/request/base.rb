require_relative 'connection'
require_relative 'validator'

module Paymill
  module Request
    class Base
      attr_reader :info
      def initialize(info)
        @info = info
      end

      def send
        raise AuthenticationError if Paymill.api_key.nil?
        connection.setup_https
        send_request
        return validator.validated_data_for(response)
      end

      private
      def send_request
        @response = connection.request
      end

      def response
        @response
      end

      def connection
        @connection ||= Connection.new(info)
      end

      def validator
        @validator ||= Validator.new(info)
      end
    end
  end
end
