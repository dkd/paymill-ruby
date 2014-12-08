module Paymill
  class Client < Base
    include Restful::Update
    include Restful::Delete

    attr_accessor :email, :description
    attr_reader :payments, :subscriptions

    protected
    def self.allowed_arguments
      [:email, :description]
    end

    def self.mandatory_arguments
      []
    end

  end
end
