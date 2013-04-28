module Paymill
  class Subscription < Base
    include Paymill::Operations::Delete
    include Paymill::Operations::Update

    attr_accessor :id, :offer, :livemode, :cancel_at_period_end, :canceled_at, :client,
                  :trial_start, :trial_end, :next_capture_at

    # Parses UNIX timestamps and creates Time objects
    def parse_timestamps
      super
      @next_capture_at = Time.at(next_capture_at) if next_capture_at
      @canceled_at     = Time.at(canceled_at) if canceled_at
      @trial_start     = Time.at(trial_start) if trial_start
      @trial_end       = Time.at(trial_end)   if trial_end
    end
  end
end
