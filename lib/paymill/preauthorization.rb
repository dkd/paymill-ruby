module Paymill
  class Preauthorization < Base
    include Paymill::Operations::Delete

    attr_accessor :id, :amount, :status, :livemode, :payment, :preauthorization, :currency, :client
  end
end
