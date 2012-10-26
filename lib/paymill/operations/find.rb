module Paymill
  module Operations
    module Find
      def find(id)
        response = Paymill.request(:get, self.api_path(id), {})
        self.new(response["data"])
      end
    end
  end
end