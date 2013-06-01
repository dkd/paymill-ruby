module Paymill
  class Request
    def initialize(http_method, api_url, data, api_key)
      @http_method = http_method
      @api_url = api_url
      @data = data
      @api_key = api_key
    end

    def send
      raise AuthenticationError if @api_key.nil?

      https             = Net::HTTP.new(API_BASE, Net::HTTP.https_default_port)
      https.use_ssl     = true
      https.verify_mode = OpenSSL::SSL::VERIFY_PEER
      https.ca_file     = File.join(File.dirname(__FILE__), "@data/paymill.crt")
      https.start do |connection|
        if @api_url == "refunds"
          url = "/#{API_VERSION}/#{@api_url}/#{@data[:id]}"
          @data.delete(:id)
        else
          url = "/#{API_VERSION}/#{@api_url}"
        end
        https_request = case @http_method
                        when :post
                          Net::HTTP::Post.new(url)
                        when :put
                          Net::HTTP::Put.new(url)
                        when :delete
                          Net::HTTP::Delete.new(url)
                        else
                          Net::HTTP::Get.new(path_with_params(url, @data))
                        end
        https_request.basic_auth(@api_key, "")
        https_request.set_form_data(data) if [:post, :put].include? @http_method
        @response = https.request(https_request)
      end
      raise AuthenticationError if @response.code.to_i == 401
      raise APIError if @response.code.to_i >= 500

      @data = JSON.parse(@response.body)
      raise APIError.new(@data["error"]) if @data["error"]

      @data
    end

    private
    # Builds and encodes a URI using given path and params.
    #
    # @param [String] path The path to use
    # @param [Array] params The params to use
    # @return [String] The built URI.
    def path_with_params(path, params)
      unless params.empty?
        encoded_params = URI.encode_www_form(params)
        [path, encoded_params].join("?")
      else
        path
      end
    end
  end
end
