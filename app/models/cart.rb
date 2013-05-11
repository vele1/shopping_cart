class Cart
  
  attr_reader :items
  
  def initialize
    @items = []
  end
  

  def add_product(product, qty)
    item = @items.find {|item| item.product == product}
    if item
      item.increment_quantity(qty)
    else    
      item = CartItem.new(product, qty)
      @items << item
    end
    @items
  end

  def update_product(product, qty)
    item = @items.find {|item| item.product == product}
    if qty.to_i == 0
      @items.delete(item)
    else
      item.update_quantity(qty)
    end
    @items
  end

  def total_items
    @items.sum { |item| item.quantity }
  end
    
  def total_price
    @items.sum { |item| item.price }
  end

  def shipping_cost
    0
  end
end
