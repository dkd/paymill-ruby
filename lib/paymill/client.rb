module Paymill
  class Client < Base
    include Paymill::Operations::Delete
    include Paymill::Operations::Update

    attr_accessor :id, :email, :description, :attributes, :created_at,
                  :updated_at, :payment, :subscription
  end
end
