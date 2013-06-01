module Paymill
  class Payment < Base
    include Paymill::Operations::Delete

    attr_accessor :id, :card_type, :country, :expire_month, :expire_year,
                  :card_holder, :holder, :last4, :account, :code, :client,
                  :type
  end
end
