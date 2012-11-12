module Paymill
  module Concerns
    module Naming
      def api_path(*args)
        [collection_name].concat(args).compact.join('/')
      end
    
      def collection_name
        if superclass == Paymill::Resource
          name.split("::").last.downcase + 's'
        else
          superclass.collection_name
        end
      end
    end
  end
end