module Paymill
  class Webhook < Base
    attr_accessor :id, :url, :livemode, :event_types
    
  end
end