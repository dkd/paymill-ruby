module Paymill
  class Client < Model
    extend Paymill::Operations::Delete
    attr_accessor :id, :email, :description, :attributes, 
                  :created_at, :updated_at,
                  :creditcard, :subscription
  end
end
