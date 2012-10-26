module Paymill
  module Operations
    module All
      def all()
        response = Paymill.request(:get, self.api_path, {})
        response["data"].map { |obj| self.new(obj) }
      end
    end
  end
end