module Paymill
  module Operations
    module Update

      def update(attributes)
        response = Paymill.request(:put, "#{self.class.name.split("::").last.downcase}s/#{id}", attributes)
        set_attributes(response["data"])
      end

    end
  end
end
