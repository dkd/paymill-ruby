module Paymill
  module Request
    class Connection
      include Helpers
      attr_reader :https

      def initialize(request_info)
        @info = request_info
      end

      def setup_https
        @https             = Net::HTTP.new(Paymill.api_base, Paymill.api_port)
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

        if [:post, :put].include?(@info.http_method)
          https_request.set_form_data(normalize_params(@info.data))
        end

        https_request
      end
    end
  end
end
