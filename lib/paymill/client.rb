module Paymill
  class Client < Resource
    attr_reader :payment, :subscription
    attr_accessor :email, :description     
#    QUERY_PARAMS = [:count, :offset, :created_at, :creditcard, :email]
  end
end