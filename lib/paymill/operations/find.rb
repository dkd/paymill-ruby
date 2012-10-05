module Paymill
  module Operations
    module Find
      module ClassMethods
        def find(id = nil)
          if id.nil?
            response = Paymill.request(:get, "#{self.name.split("::").last.downcase}s/", {})
            results = []
            response.each do |obj|
              puts "######"
              puts obj.inspect
              yay = self.new(obj)
              puts "######"
              puts yay.class
              puts "######"
              puts yay.inspect
              puts "######"
              results << yay
            end
            results
          else
            response = Paymill.request(:get, "#{self.name.split("::").last.downcase}s/#{id}", {})
            self.new(response["data"])
          end
        end
      end

      def self.included(base)
        base.extend(ClassMethods)
      end
    end
  end
end