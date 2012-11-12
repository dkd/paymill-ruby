module Paymill
  module Concerns
    module Crud
      def create(attributes)
        _request(:post, nil, attributes)
      end
      
      def find(id)
        _request(:get, id)
      end
      
      def update(id, attributes)
        _request(:put, id, attributes)
      end
    
      def delete(id)
        _request(:delete, id)
      end
      
      private
      
      def _request(method, id=nil, payload={})
        response = Paymill.request(method, api_path(id), payload)
        return true if method == :delete
        new(response['data'])        
      end
    end
  end
end