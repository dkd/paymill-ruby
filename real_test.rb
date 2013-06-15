ENV['test'] = 'payments'
require 'paymill'
require 'pry'
Paymill.api_key = "c1cd1c999078fd502350680f0de165c3:"

if ENV['test'] == 'payments'
  valid_attributes = {
      card_type:    "visa",
      country:      "germany",
      expire_month: 12,
      expire_year:  2012,
      card_holder:  "Stefan Sprenger",
      last4:        "1111",
    }
  credit_card = Paymill::Payment.create valid_attributes.merge({token: "098f6bcd4621d373cade4e832627b4f6"})
  p credit_card

  debit_card = Paymill::Payment.create valid_attributes.merge({type: "debit", code: "12345678", account: "1234512345", holder: "Max Mustermann"})
  p debit_card

  debit_card_again = Paymill::Payment.find debit_card.id
  p debit_card_again

  all_cards = Paymill::Payment.all
  p all_cards

  Paymill::Payment.delete debit_card.id
  p Paymill::Payment.find debit_card.id
end

