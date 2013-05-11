module StoreHelper

  # Formats +amount+ into something like '0000.00'
  def format_money(amount)
    number_to_currency amount.to_s, {:unit => "", :delimiter => '', :seperator => '.'}
  end
end
