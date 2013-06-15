require_relative 'connection'
require_relative 'validator'

module Paymill
  module Request
    class Base
      attr_reader :info

      def initialize(info)
        @info = info
      end

      def perform
        raise AuthenticationError if Paymill.api_key.nil?
        connection.setup_https
        send_request
        return validator.validated_data_for(response)
      end

      private
      attr_accessor :response

      def send_request
        self.response = connection.request
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
