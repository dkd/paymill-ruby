module Paymill
  class Webhook < Base
    extend Paymill::Restful::Update
    extend Paymill::Restful::Delete

    attr_reader :url, :email, :livemode
    attr_accessor :event_types, :active

    def email=( email )
      @url = nil
      @email = email
    end

    def url=( url )
      @url = url
      @email = nil
    end

    def self.create_with?( incoming_arguments )
      raise ArgumentError unless incoming_arguments.include?( :email ) || incoming_arguments.include?( :url )
      incoming_arguments.delete :email
      incoming_arguments.delete :url
      super
    end

    protected
    def self.mandatory_arguments
      [:event_types]
    end

    def self.allowed_arguments
      [:event_types, :active]
    end
  end
end
