module Paymill
  class Transaction < Base
    include Paymill::Operations::Update

    attr_accessor :id, :amount, :status, :description, :livemode,
                  :payment, :currency, :client, :response_code,
                  :origin_amount, :refunds
  end
end
