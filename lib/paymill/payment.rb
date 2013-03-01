module Paymill
  class Payment < Base
    include Paymill::Operations::Delete

    attr_accessor :id, :card_type, :country, :expire_month, :expire_year,
                  :card_holder, :last4, :created_at, :updated_at
  end
end
