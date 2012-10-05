module Paymill
  module Operations
    module Find
      module ClassMethods
        def find(id = nil)
          if id.nil?
            response = Paymill.request(:get, "#{self.name.split("::").last.downcase}s/", {})
          else
            response = Paymill.request(:get, "#{self.name.split("::").last.downcase}s/#{id}", {})
          end
          self.new(response["data"])
        end
      end

      def self.included(base)
        base.extend(ClassMethods)
      end
    end
  end
end