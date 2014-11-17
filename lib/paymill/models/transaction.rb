module Paymill
  class Transaction < Base
    extend Restful::Update

    attr_accessor :description
    attr_reader :amount, :client, :currency, :origin_amount, :status, :livemode, :refunds,
                :response_code, :is_fraud, :short_id, :fees, :invoices, :payment, :preauthorization

    protected
    def self.create_with?( incoming_arguments )
      raise ArgumentError unless incoming_arguments.any? { |e| mutual_excluded_arguments.include? e } && ( incoming_arguments & mutual_excluded_arguments ).size == 1
      super( incoming_arguments - mutual_excluded_arguments )
    end

    def self.mandatory_arguments
      [:amount, :currency]
    end

    def self.allowed_arguments
      [:amount, :client, :currency, :description, :preauthorization, :fee_amount, :fee_payment, :fee_currency]
    end

    private
    def self.mutual_excluded_arguments
      [:token, :payment, :preauthorization]
    end

  end
end
