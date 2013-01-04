module Paymill
  class Base
    include Paymill::Operations::All
    include Paymill::Operations::Create
    include Paymill::Operations::Find

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
