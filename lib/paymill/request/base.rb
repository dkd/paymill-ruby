module Paymill
  module Request
    class Base
      attr_reader :info
      attr_accessor :response

      def initialize(info)
        @info = info
      end

      def perform
        connection.setup_https
        send_request

        validator.validated_data_for(response)
      end

      protected

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
