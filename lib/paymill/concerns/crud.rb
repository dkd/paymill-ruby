module Paymill
  module Concerns
    module Crud
      def create(attributes)
        init_response Paymill.request(:post, api_path, attributes)
      end
      
      def find(id)
        init_response Paymill.request(:get, api_path(id))
      end
      
      def update(id, attributes)
        init_response Paymill.request(:put, api_path(id), attributes)
      end
    
      def delete(id)
        Paymill.request(:delete, api_path(id))
        true
      end
      
      private
      
      def init_response(response)
        new(response['data'])
      end
    end
  end
end