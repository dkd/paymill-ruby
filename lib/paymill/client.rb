module Paymill
  class Client < Resource
    # https://www.paymill.com/de-de/dokumentation/referenz/api-referenz/index.html#document-clients

    # email:        String or null -> Mail address of this client
    # description:  String or null -> Additional description for this client, perhaps the identifier from your CRM system?
    # payment:      List -> creditcard-object or directdebit-object
    # subscription: Hash or null -> subscriptions-object
    
    attr_accessor :email, :description, :subscription, :payment

    def subscribe!(offer_id, payment_id=nil)
      Subscription.create({ client: id, offer: offer_id, payment: payment_id })
    end
    
    def subscriptions
      Array(subscription).map do |sub|
        Subscription.build(sub.merge(client: self))
      end
    end
    
    def payments
      Array(payment).map do |pay|
        Payment.build(pay.merge(client: self))
      end
    end
    
    def transactions
      Transaction.where(client: id)
    end
  end
end