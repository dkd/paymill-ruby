module Paymill
  module Concerns
    module Attributes
            
      def initialize(attributes={})
        load attributes if attributes
      end
    
      def read_attribute(name)
        instance_variable_get("@#{name}".to_sym)
#        @attributes.fetch(name, nil)
      end
      alias :[] :read_attribute
    
      def write_attribute(name, value)
        instance_variable_set("@#{name}".to_sym, value)
#        @attributes[name] = value
      end
      alias :[]= :write_attribute


      def created_at=(value)
        write_attribute :created_at, Time.at(value)
      end
    
      def updated_at=(value)
        write_attribute :updated_at, Time.at(value)
      end

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