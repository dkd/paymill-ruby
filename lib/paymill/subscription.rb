module Paymill
  class Subscription < Base
    include Paymill::Operations::Delete
    include Paymill::Operations::Update

    attr_accessor :id, :plan, :livemode, :cancel_at_period_end, :created_at, :updated_at,
                  :canceled_at, :client
  end
end
