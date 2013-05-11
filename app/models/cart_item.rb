class CartItem
  
  attr_reader :product, :quantity
  
  def initialize(product, quantity)
    @product = product
    @quantity = quantity.to_i
  end
  
  def increment_quantity(quantity)
    @quantity += quantity.to_i
  end

  def update_quantity(quantity)
    @quantity = quantity.to_i
  end
  
  def title
    @product.title
  end
  
  def price
    @product.price * @quantity
  end
end
