module Paymill
  class Webhook < Base
    include Paymill::Operations::Delete
    include Paymill::Operations::Update

    attr_accessor :id, :url, :livemode, :event_types
  end
end
