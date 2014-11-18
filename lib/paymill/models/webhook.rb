module Paymill
  class Webhook < Base
    extend Restful::Update
    extend Restful::Delete

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

    protected
    def self.create_with?( incoming_arguments )
      raise ArgumentError unless incoming_arguments.any? { |e| mutual_excluded_arguments.include? e } && ( incoming_arguments & mutual_excluded_arguments ).size == 1
      super( incoming_arguments - mutual_excluded_arguments )
    end

    def self.mandatory_arguments
      [:event_types]
    end

    def self.allowed_arguments
      [:event_types, :active]
    end

    def self.mutual_excluded_arguments
      [:email, :url]
    end
  end
end
