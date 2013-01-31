module Paymill
  class Preauthorization < Base
    attr_accessor :id, :amount, :status, :livemode, :payment, :preauthorization,
                  :currency, :client, :created_at, :updated_at
  end
end
