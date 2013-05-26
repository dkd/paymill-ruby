module Paymill
  class Transaction < Base
    attr_accessor :id, :amount, :status, :description, :livemode,
                  :payment, :currency, :client, :response_code,
                  :origin_amount
  end
end
