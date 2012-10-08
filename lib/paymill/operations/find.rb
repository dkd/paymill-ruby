module Paymill
  module Operations
    module Find
      module ClassMethods
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