module Paymill
  class Base
    extend Paymill::Restful::Find
    extend Paymill::Restful::Create

    attr_reader :id, :created_at, :updated_at, :app_id

    def initialize( json )
      deserialize( json )
      parse_timestamps
    end

    def self.create_with?( incoming_arguments )
      return false if mandatory_arguments.select { |a| incoming_arguments.include? a }.size < mandatory_arguments.size
      allowed_arguments.size == ( allowed_arguments | incoming_arguments ).size
    end

    protected
    # Parses UNIX timestamps and creates Time objects.
    def parse_timestamps
      @created_at &&= Time.at( @created_at )
      @updated_at &&= Time.at( @updated_at )
    end

    private
    def deserialize( json )
      json.each_pair do |key, value|
        case value.class.name
        when 'Array'
          instance_variable_set( "@#{key.pluralize}", value.map { |e| (e.is_a? String) ? e : objectize( key, e ) } )
        when 'Hash'
          instance_variable_set( "@#{key}", objectize( key, value ) )
        else
          value = Integer( value ) rescue value
          instance_variable_set( "@#{key}", value )
        end
      end
    end

    # Converts the given 'hash' object into an instance of class with name stored in 'clazz' variable
    def objectize( clazz, hash )
      "#{self.class.name.deconstantize}::#{clazz.classify}".constantize.new( hash )
    end

  end
end
