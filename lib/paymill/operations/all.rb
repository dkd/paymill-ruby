module Paymill
  module Operations
    module All
      def all()
        response = Paymill.request(:get, api_path, {})
        response["data"].map { |obj| new(obj) }
      end
    end
  end
end