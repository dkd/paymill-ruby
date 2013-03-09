module Paymill
  class Preauthorization < Base
    attr_accessor :id, :amount, :status, :livemode, :payment, :preauthorization, :currency, :client
  end
end
