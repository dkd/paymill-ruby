module Paymill
  class Payment < Resource
    # https://www.paymill.com/de-de/dokumentation/referenz/api-referenz/index.html#document-directdebit

    def client
      Client.find(read_attribute(:client))
    end
    
    def holder
      read_attribute(:holder)
    end
    
    
    def self.new_from_type(attributes)
      case attributes.delete(:type)
      when 'creditcard'
        CreditCard.new(attributes)
      when 'debit'
        DebitCard.new(attributes)
      end
    end
  end
end