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
      end

      def request
        response = https.start do |connection|
          https.request(https_request)
        end
        log_request_info(response)
        response
      end

      private

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

      def log_request_info(response)
        if @info
          Paymill.logger.info "[Paymill] [#{current_time}] #{@info.http_method.upcase} #{@info.url} #{response.code}"
        end
      end

      def current_time
        Time.now.utc.strftime("%d/%b/%Y %H:%M:%S %Z")
      end
    end
  end
end
