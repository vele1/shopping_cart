class Order < ActiveRecord::Base
  has_many :line_items
  belongs_to :customer,
             :class_name => 'User',
             :foreign_key => 'user_id'

    # Generate reference for order
  def generate_reference(user)
     Time.now.strftime("%d%m%y%H%M")
  end

  def before_create
    self[:order_date] = Date.today
  end

  def total_price
    total = line_items.collect {|i| i.quantity * i.unit_price }.sum
    return total.to_f + shipping_cost.to_f
  end

  def items=(collection)
    collection.each do |ci|
      LineItem.create(:product_id => ci.product.id, :quantity => ci.quantity, :unit_price => ci.product.price, :order_id => self.id)
    end
  end

  def self.generate_reference
    Order.next_invoice_suffix
  end

  def self.next_invoice_suffix
    previous = Order.find(:first, :order => 'id DESC')

    if previous.nil? || previous.order_no.blank?
      "EP000001"
    # make a new higher prefix
    else
      previous.order_no.succ.rjust(7, "0")
    end
  end
end
