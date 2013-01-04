module Paymill
  class Transaction < Base
    attr_accessor :id, :amount, :status, :description, :livemode,
                  :payment, :currency, :client, :created_at, :updated_at
  end
end
