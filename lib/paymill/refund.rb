module Paymill
  class Refund < Base
    attr_accessor :id, :transaction, :amount, :status, :description, :livemode
  end
end
