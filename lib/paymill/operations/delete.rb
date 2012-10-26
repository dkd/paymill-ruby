module Paymill
  module Operations
    module Delete
      def delete(id)
        response = Paymill.request(:delete, "#{self.name.split("::").last.downcase}s/#{id}", {})
        true
      end
    end
  end
end