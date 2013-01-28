module Paymill
  class Refund < Base
    attr_accessor :id, :transaction, :amount, :status, :description,
                  :livemode, :created_at, :updated_at
  end
end
