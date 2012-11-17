module Paymill
  module Concerns
    module LiveMode
      def live?
        read_attribute(:livemode)
      end
      
      def test?
        !live?
      end
    end
  end
end