module Paymill
  module Operations
    module Find
      def find(id)
        response = Paymill.request(:get, api_path(id), {})
        new(response["data"])
      end
    end
  end
end