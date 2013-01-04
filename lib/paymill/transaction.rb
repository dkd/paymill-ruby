module Paymill
  class Transaction < Base
    include Paymill::Operations::All
    include Paymill::Operations::Create
    include Paymill::Operations::Find

    attr_accessor :id, :amount, :status, :description, :livemode,
                  :payment, :currency, :client, :created_at, :updated_at

  end
end
