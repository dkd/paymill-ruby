module Paymill
  class Offer
    include Paymill::Operations::Create
    include Paymill::Operations::Find

    attr_accessor :id, :name, :amount, :interval, :trial_period_days, :currency

    def initialize(attributes = {})
      attributes.each_pair do |key, value|
        instance_variable_set("@#{key}", value)
      end
      @attributes  = attributes
    end
  end
end