module Paymill
  class Client < Base
    include Paymill::Operations::All
    include Paymill::Operations::Create
    include Paymill::Operations::Find
    include Paymill::Operations::Update
    include Paymill::Operations::Delete

    attr_accessor :id, :email, :description, :attributes, :created_at,
                  :updated_at, :payment, :subscription

  end
end
