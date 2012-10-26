module Paymill
  class Model
    extend Paymill::Operations::All
    extend Paymill::Operations::Create
    extend Paymill::Operations::Find

    def initialize(attributes = {})
      attributes.each_pair do |key, value|
        instance_variable_set("@#{key}", value)
      end
    end
  end
end