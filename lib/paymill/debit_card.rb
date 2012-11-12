module Paymill
  class DebitCard < Payment
    attr_reader :type, :client, :code, :account, :holder
#    QUERY_PARAMS = [:count, :offset, :created_at]   
  end
end