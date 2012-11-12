module Paymill
  class Transaction < Resource
    attr_accessor :amount, :origin_amount, :status, :description, :livemode, :payment, :client, :preauthrizations
#    QUERY_PARAMS = [:count, :offset, :created_at]
  end
end