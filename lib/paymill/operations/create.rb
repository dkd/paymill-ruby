module Paymill
  module Operations
    module Create
      def create(attributes)
        response = Paymill.request(:post, "#{self.name.split("::").last.downcase}s", attributes)
        self.new(response["data"])
      end
    end
  end
end