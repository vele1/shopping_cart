class LineItem < ActiveRecord::Base

  # Define our relashinship.
  belongs_to :product
  belongs_to :order

  # Create a line item for the product.
  def self.for_product(product)
    item = self.new
    item.quantity = 1
    item.product = product
    item.unit_price = product.price
    item
  end
end
