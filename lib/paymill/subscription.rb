module Paymill
  class Subscription
    include Paymill::Operations::Create
    include Paymill::Operations::Delete
    include Paymill::Operations::Find
    include Paymill::Operations::All

    attr_accessor :id, :plan, :livemode, :cancel_at_period_end, :created_at, :updated_at,
                  :canceled_at, :client

    def initialize(attributes = {})
      attributes.each_pair do |key, value|
        instance_variable_set("@#{key}", value)
      end
    end
  end
end