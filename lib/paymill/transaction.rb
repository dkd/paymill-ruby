module Paymill
  class Transaction < Base
    attr_accessor :id, :amount, :status, :description, :livemode,
                  :payment, :currency, :client, :response_code
  end
end
