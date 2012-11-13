module Paymill
  class CreditCard < Payment
    # https://www.paymill.com/de-de/dokumentation/referenz/api-referenz/index.html#document-creditcard
    # id,           string, Unique identifier for this credit card
    # type,         enum(creditcard), 
    # client,       string or null, The identifier of a client (client-object)
    # card_type,    enum(visa, mastercard), Visa or Mastercard
    # country,      string, Country
    # expire_month, integer, Expiry month of this credit card
    # expire_year,  integer, Expiry year of this credit card
    # card_holder,  string or null, Name of the card holder
    # last4,        string, The last four digits of the credit card
    # created_at,   integer, Unix-Timestamp for the creation date
    # updated_at,   integer, Unix-Timestamp for the Last Update

    # attribute :type,         String
    # attribute :client,       String
    # attribute :card_type,    String
    # attribute :country,      String
    # attribute :expire_month, Integer
    # attribute :expire_year,  Integer
    # attribute :card_holder,  String
    # attribute :last4,        String
    attr_reader :type, :client, :country, :card_type, :expire_month, :expire_year, :last4    
#    QUERY_PARAMS = [:count, :offset, :created_at]

    def holder
      read_attribute(:card_holder)
    end
    
    def expire_date
      Date.new(expire_year, expire_month)
    end    
    
    def visa?
      card_type == 'visa'
    end
    
    def mastercard?
      card_type == 'mastercard'
    end
    
    def number(placeholder="\u2022")
      last4.to_s.rjust(16, placeholder)
    end
  end
end