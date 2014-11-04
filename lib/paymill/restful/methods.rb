module Paymill
  module Restful

    module Find
      def find( model )
        model = model.id if model.is_a? self
        #TODO[VNi] raise ArgumentError if id is blank
        response = Paymill.request( Http.get( name.demodulize.tableize, model ) )
        new( response['data'] )
      end
    end

    module Create
      def create( attributes = {} )
        raise ArgumentError unless create_with?( attributes.keys )
        attributes = Restful.normalize( attributes )
        response = Paymill.request( Http.post( name.demodulize.tableize, attributes ) )
        new( response['data'] )
      end
    end

    module Update
      # TODO[VNi]: test to have public update with model, which calls protected update with model and attributes
      def update( model, attributes = {} )
        #TODO[VNi] raise error when other type object is given
        #TODO[VNi] raise error object's id is blank
        attributes.merge! model.public_methods( false ).grep( /.*=/ ).map{ |m| m = m.id2name.chop; { m => model.send( m ) } }.reduce( :merge )
        attributes = Restful.normalize( attributes )
        response = Paymill.request( Http.put( name.demodulize.tableize, model.id, attributes ) )
        new( response['data'] )
      end
    end

    module Delete
      def delete( model, attributes = {} )
        #TODO[VNi] raise error when other type object is given
        model = model.id if model.is_a? self
        Paymill.request( Http.delete( name.demodulize.tableize, model, attributes ) )
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
      parameters = attributes.clone
      attributes
    end
  end

  module Http
    def self.get( endpoint, id )
      request = Net::HTTP::Get.new( "/#{Paymill.api_version}/#{endpoint}/#{id}" )
      request.basic_auth( Paymill.api_key, '' )
      request
    end

    def self.post( endpoint, attributes )
      request = Net::HTTP::Post.new( "/#{Paymill.api_version}/#{endpoint}" )
      request.basic_auth( Paymill.api_key, '' )
      request.set_form_data( attributes )
      request
    end

    def self.put( endpoint, id, attributes )
      request = Net::HTTP::Put.new( "/#{Paymill.api_version}/#{endpoint}/#{id}" )
      request.basic_auth( Paymill.api_key, '' )
      request.set_form_data( attributes )
      request
    end

    def self.delete( endpoint, id, attributes )
      request = Net::HTTP::Delete.new( "/#{Paymill.api_version}/#{endpoint}/#{id}" )
      request.basic_auth( Paymill.api_key, '' )
      request.set_form_data( attributes ) unless attributes.empty?
      request
    end
  end
end
