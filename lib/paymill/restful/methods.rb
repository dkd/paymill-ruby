module Paymill
  module Restful

    module All
      def all( arguments = {} )
        unless arguments.empty?
          order = "#{arguments[:order].map{ |e| "order=#{e.id2name}" }.join( '&' )}" if arguments[:order]
          filters = arguments[:filters].map{ |hash| hash.map{ |key, value| "#{key.id2name}=#{value.gsub( ' ', '+' ) }" }.join( '&' ) } if arguments[:filters]
          count = "count=#{arguments[:count]}" if arguments[:count]
          offset = "offset=#{arguments[:offset]}" if arguments[:offset]
          arguments = "?#{[order, filters, offset, count].reject { |e| e.nil? }.join( '&' )}"
        else
          arguments = ''
        end

        response = Paymill.request( Http.all( name.demodulize.tableize, arguments ) )
        enrich_array_with_data_count( response['data'].map!{ |element| new( element ) }, response['data_count'] )
      end

      private
      def enrich_array_with_data_count( array, data_count )
        array.instance_variable_set( '@data_count', data_count )
        def array.data_count
          @data_count
        end
        array
      end
    end

    module Find
      def find( model )
        model = model.id if model.is_a? self
        response = Paymill.request( Http.get( name.demodulize.tableize, model ) )
        new( response['data'] )
      end
    end

    module Create
      def create( arguments = {} )
        raise ArgumentError unless create_with?( arguments.keys )
        response = Paymill.request( Http.post( name.demodulize.tableize, Restful.normalize( arguments ) ) )
        new( response['data'] )
      end
    end

    module Update
      def update( arguments = {} )
        arguments.merge! public_methods( false ).grep( /.*=/ ).map{ |m| m = m.id2name.chop; { m => send( m ) } }.reduce( :merge )
        response = Paymill.request( Http.put( self.class.name.demodulize.tableize, self.id, Restful.normalize( arguments ) ) )
        source = self.class.new( response['data'] )
        self.instance_variables.each { |key| self.instance_variable_set( key, source.instance_variable_get( key ) ) }
      end
    end

    module Delete
      def delete( arguments = {} )
        response = Paymill.request( Http.delete( self.class.name.demodulize.tableize, self.id, arguments ) )
        return self.class.new( response['data'] ) if self.class.name.eql? 'Paymill::Subscription'
        nil
      end
    end

    private
    def self.normalize( parameters = {} )
      attributes = {}.compare_by_identity
      parameters.each do |key, value|
        if value.is_a? Array
          value.each { |e| attributes["#{key.to_s}[]"] = e }
        elsif value.is_a? Base
          attributes[key.to_s] = value.id
        elsif value.is_a? Time
          attributes[key.to_s] = value.to_i
        else
          attributes[key.to_s] = value unless value.nil?
        end
      end
      attributes
    end
  end

  module Http
    def self.all( endpoint, arguments )
      request = Net::HTTP::Get.new( "/#{Paymill.api_version}/#{endpoint}#{arguments}" )
      request.basic_auth( Paymill.api_key, '' )
      request
    end

    def self.get( endpoint, id )
      request = Net::HTTP::Get.new( "/#{Paymill.api_version}/#{endpoint}/#{id}" )
      request.basic_auth( Paymill.api_key, '' )
      request
    end

    def self.post( endpoint, id = nil, arguments )
      request = Net::HTTP::Post.new( "/#{Paymill.api_version}/#{endpoint}/#{id}" )
      request.basic_auth( Paymill.api_key, '' )
      request.set_form_data( arguments )
      request
    end

    def self.put( endpoint, id, arguments )
      request = Net::HTTP::Put.new( "/#{Paymill.api_version}/#{endpoint}/#{id}" )
      request.basic_auth( Paymill.api_key, '' )
      request.set_form_data( arguments )
      request
    end

    def self.delete( endpoint, id, arguments )
      arguments = arguments.map { |key, value| "#{key.id2name}=#{value}" }.join( '&' )
      arguments = "?#{arguments}" unless arguments.empty?
      request = Net::HTTP::Delete.new( "/#{Paymill.api_version}/#{endpoint}/#{id}#{arguments}" )
      request.basic_auth( Paymill.api_key, '' )
      # request.set_form_data( arguments ) unless arguments.empty?
      request
    end
  end
end
