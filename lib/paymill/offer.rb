module Paymill
  class Offer < Base
    include Paymill::Operations::All
    include Paymill::Operations::Create
    include Paymill::Operations::Delete
    include Paymill::Operations::Find

    attr_accessor :id, :name, :amount, :interval, :trial_period_days, :currency


  end
end
