module Paymill
  class Subscription < Base
    include Paymill::Operations::Delete
    include Paymill::Operations::Update

    attr_accessor :id, :plan, :livemode, :cancel_at_period_end, :canceled_at, :client, :trial_start, :trial_end

    def parse_timestamps
      super
      @canceled_at = Time.at(canceled_at) if canceled_at
      @trial_start = Time.at(trial_start) if trial_start
      @trial_end   = Time.at(trial_end)   if trial_end
    end
  end
end
