module Paymill
  module Operations
    module Find
      def find(id)
        response = Paymill.request(:get, "#{self.name.split("::").last.downcase}s/#{id}", {})
        self.new(response["data"])
      end
    end
  end
end