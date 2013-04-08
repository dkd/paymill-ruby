module Paymill
  module Operations
    module Find
      module ClassMethods
        # Finds a given object
        #
        # @param [Integer] id The id of the object that should be found
        # @return [Paymill::Base] The found object
        def find(id)
          response = Paymill.request(:get, "#{self.name.split("::").last.downcase}s/#{id}", {})
          self.new(response["data"])
        end
      end

      def self.included(base)
        base.extend(ClassMethods)
      end
    end
  end
end
