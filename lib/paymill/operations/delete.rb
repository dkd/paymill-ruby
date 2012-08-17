module Paymill
  module Operations
    module Delete
      module ClassMethods
        def delete(id)
          response = Paymill.request(:delete, "#{self.name.split("::").last.downcase}s/#{id}", {})
          true
        end
      end

      def self.included(base)
        base.extend(ClassMethods)
      end
    end
  end
end