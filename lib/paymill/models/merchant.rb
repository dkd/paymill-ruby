module Paymill
  class Merchant

    attr_accessor :identifier_key, :email, :locale, :country, :currencies, :methods

    def initialize( json )
      deserialize( json )
    end

    private
    def deserialize( json )
      case value.class.name
      when 'Array'
        instance_variable_set( "@#{key.pluralize}", value.map { |e| e } )
      else
        instance_variable_set( "@#{key}", (Integer( value ) rescue value) )
      end
    end

  end
end
