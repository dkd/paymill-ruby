module Paymill
  class Client
    API_ENDPOINT = "clients"

    include Paymill::Operations::Create
    include Paymill::Operations::Find

    attr_accessor :id, :email, :description, :attributes, :created_at,
                  :updated_at, :creditcard, :subscription

    def initialize(attributes = {})
      attributes.each_pair do |key, value|
        instance_variable_set("@#{key}", value)
      end
      @attributes  = attributes
    end
  end
end