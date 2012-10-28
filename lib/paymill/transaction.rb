module Paymill
  class Transaction < Model
    attr_accessor :id, :amount, :status, :description, :livemode,
                  :creditcard, :client, :created_at, :updated_at
  end
end
