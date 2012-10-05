module Paymill
  class CreditCard
    include Paymill::Operations::Create
    include Paymill::Operations::Find

    attr_accessor :id, :card_type, :country, :expire_month, :expire_year,
                  :card_holder, :last4, :created_at, :updated_at

    def initialize(attributes = {})
      if not attributes.kind_of?(Array)
        attributes.each_pair do |key, value|
          instance_variable_set("@#{key}", value)
        end
      end
      @attributes  = attributes
    end
  end
end