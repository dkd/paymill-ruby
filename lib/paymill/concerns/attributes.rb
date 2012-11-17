module Paymill
  module Concerns
    module Attributes
            
      def initialize(attributes={})
        load attributes if attributes
      end
    
      def read_attribute(name)
        instance_variable_get("@#{name}".to_sym)
      end
      alias :[] :read_attribute
    
      def write_attribute(name, value)
        instance_variable_set("@#{name}".to_sym, value)
      end
      alias :[]= :write_attribute

      private
    
      def load(attributes)
        attributes.each do |attr, value|
          if respond_to? "#{attr}="
            self.public_send("#{attr}=", value) 
          else
            write_attribute(attr, value)
          end
        end
      end
      
    end
  end
end