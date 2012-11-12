module Paymill
  class Preauthorization < Resource
    attr_reader :amount, :status, :livemode, :payment, :client
#    QUERY_PARAMS = [:count, :offset, :created_at]
  end
end