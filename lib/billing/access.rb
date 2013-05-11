# include this helper for coverting 10 to R10.00
#require "vendor/rails/actionpack/lib/action_view/helpers/number_helper"
#include ActionView
#include Helpers
#include NumberHelper

class Access
  class << self    
    # Convert To Money.
    # Formats +amount+ into something like 'R 0,000.00'
    def money(amount)
      number_to_currency amount.to_s, {:unit => 'R ', :delimiter => ',', :seperator => '.'}
    end
    
    def money_convert_sign(bf)
      amt =  bf < 0 ? (bf * -1) : bf
      return money(amt)
    end

    def self.calculate_vat price
      price_vat = ((price.to_f * 14)/100) + price.to_f
    end

    def self.price_excluding_vat price
      price_vat = price.to_f / 1.14
    end

    def self.price_including_vat price
      price_vat = price.to_f * 1.14
    end
  end  
end