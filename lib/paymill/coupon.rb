module Paymill
  class Coupon < Resource
    attr_accessor :name, :type, :fixed_value, :percent_value
    attr_accessor :usage_time, :valid_from, :valid_until, :max_usable
    attr_accessor :min_transaction_volume, :max_transaction_volume, :transaction_type
    
    def self.build(attrs={})
      case attrs['type'] || attrs[:type]
        when 'fixed_value'   then Coupon::Fixed.new(attrs)
        when 'percent_value' then Coupon::Percent.new(attrs)
      end
    end
    
    def valid?
      max_usable && (usage_time < max_usable) && valid_from && valid_until && (valid_from..valid_until).cover?(Time.now.to_i)
    end
    
    class Fixed < Coupon
      def self.scoped
        super.where(type: 'fixed_value')
      end
    
      def value
        fixed_value
      end
    end
  
    class Percent < Coupon
      def self.scoped
        super.where(type: 'percent_value')
      end
    
      def value
        percent_value
      end
    end
  end
end