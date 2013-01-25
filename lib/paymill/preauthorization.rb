module Paymill
  class Preauthorization < Base
    attr_accessor :id, :amount, :status, :livemode, :payment, 
                  :currency, :client, :created_at, :updated_at
  end
end
