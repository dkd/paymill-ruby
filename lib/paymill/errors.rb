module Paymill
  class PaymillError < StandardError
  end

  class AuthenticationError < PaymillError
  end

  class NotFoundError < PaymillError
  end
end
