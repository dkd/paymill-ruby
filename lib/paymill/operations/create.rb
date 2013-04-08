module Paymill
  module Operations
    module Create
      module ClassMethods
        # Creates a new object
        #
        # @param [Hash] attributes The attributes of the created object
        def create(attributes)
          response = Paymill.request(:post, "#{self.name.split("::").last.downcase}s", attributes)
          self.new(response["data"])
        end
      end

      def self.included(base)
        base.extend(ClassMethods)
      end
    end
  end
end
