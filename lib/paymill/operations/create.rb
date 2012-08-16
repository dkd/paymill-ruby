module Paymill
  module Operations
    module Create
      module ClassMethods
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