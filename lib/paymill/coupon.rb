module Paymill
  class Coupon < Resource
    attr_accessor :name, :type, :fixed_value, :percent_value
    attr_accessor :usage_time, :valid_from, :valid_until, :max_usable
    attr_accessor :min_transaction_volume, :max_transaction_volume, :transaction_type
  end
end