module Paymill
  class CreditCard < Payment
    # https://www.paymill.com/de-de/dokumentation/referenz/api-referenz/index.html#document-creditcard
    # id:           String, Unique identifier for this credit card
    # type:         Enum(creditcard), 
    # client:       String or null, The identifier of a client (client-object)
    # card_type:    Enum(visa, mastercard), Visa or Mastercard
    # country:      String, Country
    # expire_month: Integer, Expiry month of this credit card
    # expire_year:  Integer, Expiry year of this credit card
    # card_holder:  String or null, Name of the card holder
    # last4:        String, The last four digits of the credit card
    # created_at:   Integer, Unix-Timestamp for the creation date
    # updated_at:   Integer, Unix-Timestamp for the Last Update

    attr_accessor :card_type, :country, :expire_month, :expire_year, :card_holder, :last4

    alias :holder :card_holder
    alias :holder= :card_holder=

    def visa?
      card_type == 'visa'
    end
    
    def mastercard?
      card_type == 'mastercard'
    end
    
    def expire_date
      Date.new(expire_year, expire_month)
    end
  end
end