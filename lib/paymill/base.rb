module Paymill
  class Base

    def initialize(attributes = {})
      set_attributes(attributes)
    end

    def set_attributes(attributes)
      attributes.each_pair do |key, value|
        instance_variable_set("@#{key}", value)
      end
    end

  end
end
