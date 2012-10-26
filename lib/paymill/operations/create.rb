module Paymill
  module Operations
    module Create
      def create(attributes)
        response = Paymill.request(:post, self.api_path, attributes)
        self.new(response["data"])
      end
    end
  end
end