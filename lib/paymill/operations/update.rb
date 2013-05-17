module Paymill
  module Operations
    module Update

      module ClassMethods
        # Updates a object
        # @param [Integer] id The id of the object that should be updated
        # @param [Hash] attributes The attributes that should be updated
        def update_attributes(id, attributes)
          response = Paymill.request(:put, "#{self.name.split("::").last.downcase}s/#{id}", attributes)
          self.new(response["data"])
        end
      end

      def self.included(base)
        base.extend(ClassMethods)
      end

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
