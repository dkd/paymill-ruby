module Paymill
  module Operations
    module Delete
      def delete(id)
        response = Paymill.request(:delete, api_path(id), {})
        true
      end
    end
  end
end