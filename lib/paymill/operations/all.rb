module Paymill
  module Operations
    module All
      module ClassMethods
        def all(options = {})
          response = Paymill.request(:get, "#{self.name.split("::").last.downcase}s/", options)
          results = []
          response["data"].each do |obj|
            results << self.new(obj)
          end
          results
        end
      end

      def self.included(base)
        base.extend(ClassMethods)
      end
    end
  end
end
