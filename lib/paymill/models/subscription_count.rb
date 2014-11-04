module Paymill
  class SubscriptionCount

    attr_accessor :active, :inactive

    def initialize( json )
      deserialize( json )
    end

    private
    def deserialize( json )
      json.each_pair do |key, value|
        value = Integer( value ) rescue value
        instance_variable_set( "@#{key}", value )
      end
    end

  end
end
