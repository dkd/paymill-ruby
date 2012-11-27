module Paymill
  class Transaction
    include Paymill::Operations::All
    include Paymill::Operations::Create
    include Paymill::Operations::Find

    attr_accessor :id, :amount, :status, :description, :livemode,
                  :payment, :currency, :client, :created_at, :updated_at

    def initialize(attributes = {})
      attributes.each_pair do |key, value|
        instance_variable_set("@#{key}", value)
      end
    end
  end
end
