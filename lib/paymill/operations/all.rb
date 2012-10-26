module Paymill
  module Operations
    module All
      def all()
        response = Paymill.request(:get, "#{self.name.split("::").last.downcase}s/", {})
        response["data"].map { |obj| self.new(obj) }
      end
    end
  end
end