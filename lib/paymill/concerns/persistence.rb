module Paymill
  module Concerns
    module Persistence
      def new?
        id.nil?
      end
    
      def save
        new? ? create : update
      end
    
      def delete
        self.class.delete(id) unless new?
      end
      alias :destroy :delete
    
      def reload
#        load self.class.find(id).attributes unless new?
      end
    
      private
    
      def update
  #      data = attributes_for_update
  #      load self.class.update(id, data).attributes
      end
    
      def create
  #      data = attributes_for_create
  #      load self.class.create(data).attributes
      end
      
      def attributes_for_create
        attributes.splice(*self.class.valid_attributes_for_create)
      end
      
      def attributes_for_update
        attributes.splice(*self.class.valid_attributes_for_update)
      end
    end
  end
end