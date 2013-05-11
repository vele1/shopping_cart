# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  # Formatting our date.
  def date_format(date)
    date ? date.strftime("%d %B %Y") : ""
  end

  def date_and_time_format(date)
    date ? date.strftime("%d %B %Y at %H:%M") : ""
  end

  def format_date(date)
    date ? date.strftime("%d-%m-%Y") : ""
  end

  # Formats +amount+ into something like 'R 0,000.00'
  def money(amount)
    number_to_currency amount.to_s, {:unit => 'R ', :delimiter => ',', :seperator => '.'}
  end

  # Formats +amount+ into something like '0,000.00'
  def currency(amount)
    number_to_currency amount.to_s, {:unit => "", :delimiter => ',', :seperator => '.'}
  end
end
