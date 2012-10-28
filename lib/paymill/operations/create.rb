module Paymill
  module Operations
    module Create
      def create(attributes)
        response = Paymill.request(:post, api_path, attributes)
        new(response["data"])
      end
    end
  end
end