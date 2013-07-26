class Hash
  def flatten_keys(newhash={}, keys=nil)
    self.each do |k, v|
      k = k.to_s
      keys2 = keys ? keys+"[#{k}]" : k
      if v.is_a?(Hash)
        v.flatten_keys(newhash, keys2)
      else
        newhash[keys2] = v
      end
    end
    newhash
  end
end

def normalize_params(params, key=nil)
  params = params.flatten_keys if params.is_a?(Hash)
  result = {}
  params.each do |k,v|
    case v
      when Hash
        result[k.to_s] = normalize_params(v)
      when Array
        v.each_with_index do |val,i|
          result["#{k.to_s}[#{i}]"] = val.to_s
        end
      else
        result[k.to_s] = v.to_s
    end
  end
  result
end

module Paymill
  module Request
    class Connection
      attr_reader :https

      def initialize(request_info)
        @info = request_info
      end

      def setup_https
        @https             = Net::HTTP.new(API_BASE, Net::HTTP.https_default_port)
        @https.use_ssl     = true
        @https.verify_mode = OpenSSL::SSL::VERIFY_PEER
        @https.ca_file     = File.join(ROOT_PATH, "data/paymill.crt")
      end

      def request
        https.start do |connection|
          https.request(https_request)
        end
      end

      protected

      def https_request
        https_request = case @info.http_method
                        when :post
                          Net::HTTP::Post.new(@info.url)
                        when :put
                          Net::HTTP::Put.new(@info.url)
                        when :delete
                          Net::HTTP::Delete.new(@info.url)
                        else
                          Net::HTTP::Get.new(@info.path_with_params(@info.url, @info.data))
                        end
        https_request.basic_auth(Paymill.api_key, "")
        https_request.set_form_data(normalize_params(@info.data)) if [:post, :put].include?(@info.http_method)
        https_request
      end
    end
  end
end
