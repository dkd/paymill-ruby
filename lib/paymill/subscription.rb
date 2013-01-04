module Paymill
  class Subscription < Base
    include Paymill::Operations::All
    include Paymill::Operations::Create
    include Paymill::Operations::Find
    include Paymill::Operations::Update
    include Paymill::Operations::Delete

    attr_accessor :id, :plan, :livemode, :cancel_at_period_end, :created_at, :updated_at,
                  :canceled_at, :client


  end
end
