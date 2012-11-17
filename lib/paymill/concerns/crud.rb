module Paymill
  module Concerns
    module Crud
      def build(*args)
        new(*args)
      end
      
      def create(attributes)
        request_and_build(:post, nil, attributes)
      end
      
      def find(id)
        request_and_build(:get, id)
      end
      
      def update(id, attributes)
        request_and_build(:put, id, attributes)
      end
    
      def delete(id)
        request(:delete, id) && true
      end

      private
      
      def request(method, id=nil, payload={})
        Paymill.request(method, api_path(id), payload)
      end
      
      def request_and_build(*args)
        build request(*args)['data']
      end
    end
  end
end