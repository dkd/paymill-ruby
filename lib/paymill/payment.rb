module Paymill
  class Payment < Resource
    # https://www.paymill.com/de-de/dokumentation/referenz/api-referenz/index.html#document-directdebit

    def self.build(attrs={})
      case attrs['type'] || attrs[:type]
        when 'creditcard' then CreditCard.new(attrs)
        when 'debit'      then DirectDebit.new(attrs)
      end
    end

    attr_accessor :type, :client
    
    def number(opts={})
      m = opts.fetch(:mask, "\u2022")
      s = opts.fetch(:separator, " ")
      last4.to_s.rjust(16, m).scan(/.{1,4}/m).join(s)
    end
    
    def debit?
      type == 'debit'
    end
    
    def creditcard?
      type == 'creditcard'
    end

    def visa?
      card_type == 'visa'
    end
    
    def mastercard?
      card_type == 'mastercard'
    end
  end
end