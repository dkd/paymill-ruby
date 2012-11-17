module Paymill
  class Request
    attr_reader :uri, :method, :payload, :header
    
    def initialize(method, uri, payload={})
      @method  = method
      @uri     = uri
      @payload = payload
      @header  = { "user-agent" => Paymill.user_agent }
    end

    def fetch
      Paymill.logger.info("Paymill [#{method.upcase}] #{uri.to_s} -- #{payload.inspect}") if Paymill.log?
      handle_response connection.request(request_object)
    end

    private
        
    def connection
      http = Net::HTTP.new(uri.host, uri.port)
      # ssl options
      http.use_ssl      = uri.scheme == 'https'
      http.ca_file      = File.expand_path('lib/paymill.crt')
      http.verify_mode  = OpenSSL::SSL::VERIFY_PEER
      # timeout
      http.open_timeout = http.read_timeout = http.ssl_timeout = Paymill.timeout if Paymill.timeout
      # logger
      http.set_debug_output(Paymill.logger) if Paymill.log?
      # return the http connection
      http
    end
    
    def request_object
      req = request_class.new(request_path, header)
      req.basic_auth(Paymill.api_key, '')
      req.set_form_data(payload) if post?
      req
    end
    
    def request_class
      Net::HTTP.const_get(method.to_s.capitalize)
    end

    def request_path
      uri.query = URI.encode_www_form(payload) if method==:get && !payload.empty?
      uri.request_uri
    end

    def handle_response(response)
      # raise exception if response code is not 2xx
      response.value unless response.is_a?(Net::HTTPSuccess)
      JSON.parse(response.body)
    end

    def post?
      !!(method =~ /post|put|patch/)
    end
  end
end