module Paymill
  class Offer
    include Paymill::Operations::Create
    include Paymill::Operations::Delete
    include Paymill::Operations::Find
    include Paymill::Operations::All

    attr_accessor :id, :name, :amount, :interval, :trial_period_days, :currency

    def initialize(attributes = {})
      attributes.each_pair do |key, value|
        instance_variable_set("@#{key}", value)
      end
    end
  end
end