module Paymill
  module Concerns
    module LiveMode
      attr_accessor :livemode
      
      def live?
        read_attribute(:livemode)
      end
      
      def test?
        !live?
      end
    end
  end
end