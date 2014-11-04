module Paymill
  class Payment < Base
    extend Paymill::Restful::Delete

    attr_reader :type, :client, :card_type, :country, :expire_month, :expire_year, :card_holder,
                :last4, :is_recurring, :is_usable_for_preauthorization, :code, :holder, :account

    protected
    def self.allowed_arguments
      [:token, :client]
    end

    def self.mandatory_arguments
      [:token]
    end

  end
end
