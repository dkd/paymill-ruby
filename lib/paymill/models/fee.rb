module Paymill
  class Fee

    attr_accessor :type, :application, :payment, :amount, :currency, :billed_at

    def initialize( json )
      json.each_pair do |key, value|
        instance_variable_set( "@#{key}", ( Integer( value ) rescue value ) )
      end
      @billed_at &&= Time.at( @billed_at )
    end

  end
end
