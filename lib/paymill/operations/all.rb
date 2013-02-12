module Paymill
  module Operations
    module All
      module ClassMethods
        def all(sort_and_filter_options={})
          response = Paymill.request(:get, "#{self.name.split("::").last.downcase}s/", sort_and_filter_options)
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
