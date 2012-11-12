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
    attr_reader :type, :client, :country, :card_type, :expire_month, :expire_year, :card_holder, :last4
    
    QUERY_PARAMS = [:count, :offset, :created_at]
                  
    # def self.pluralized_name
    #   'payments'
    # end
  end
end