module Paymill
  class PaymentMethod

    attr_accessor :type, :currency, :acquirer

    def initialize( json )
      deserialize( json )
    end

    private
    def deserialize( json )
      json.each_pair do |key, value|
        instance_variable_set( "@#{key}", ( Integer( value ) rescue value ) )
      end
    end

  end
end
