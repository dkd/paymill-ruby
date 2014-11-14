module Paymill
  class Invoice

    attr_accessor :invoice_nr, :netto, :brutto, :status, :period_from, :last_reminder_date,
                  :period_until, :currency, :vat_rate, :billing_date, :invoice_type

    def initialize( json )
      json.each_pair do |key, value|
        instance_variable_set( "@#{key}", ( Integer( value ) rescue value ) )
      end
      @period_from &&= Time.at( @period_from )
      @period_until &&= Time.at( @period_until )
      @billing_date &&= Time.at( @billing_date )
      @last_reminder_date &&= Time.at( @last_reminder_date )
    end

  end
end
