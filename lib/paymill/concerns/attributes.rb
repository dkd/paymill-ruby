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


      def created_at
        read_time_attribute(:created_at)
      end
    
      def updated_at
        read_time_attribute(:updated_at)
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
      
      def read_money_attribute(name)
        Money.new(read_attribute(:name))
      end
      
      def read_time_attribute(name)
        value = read_attribute(name)
        Time.at(value) unless value.nil?
      end
      
      def read_array_attribute(name, klass)
        (read_attribute(name) || []).map { |d| klass.new(d) }
      end
      
    end
  end
end