module Paymill
  module Request
    class Validator
      def initialize(info)
        @info = info
      end

      def validated_data_for(incoming_response)
        self.response = incoming_response
        verify_response_code
        info.data = JSON.parse(response.body)
        validate_response_data
        return info.data
      end

      def verify_response_code
        raise AuthenticationError if response.code.to_i == 401
        raise APIError if response.code.to_i >= 500
      end

      def validate_response_data
        raise APIError.new(info.data["error"]) if info.data["error"]
      end

      private
      attr_reader :info
      attr_accessor :response
    end
  end
end
