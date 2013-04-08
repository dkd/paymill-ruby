module Paymill
  module Operations
    module Update
      # Updates a object
      #
      # @param [Hash] attributes The attributes that should be updated
      def update_attributes(attributes)
        response = Paymill.request(:put, "#{self.class.name.split("::").last.downcase}s/#{id}", attributes)
        set_attributes(response["data"])
      end
    end
  end
end
