module Paymill
  class Refund < Resource
    attr_reader :transaction, :amount, :status, :description, :livemode   
#    QUERY_PARAMS = [:count, :offset, :created_at, :transaction, :client, :amount]
  end
end