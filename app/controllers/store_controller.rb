require 'billing/sale_invoice'
class StoreController < ApplicationController
  skip_before_filter :check_authentication, :check_authorization, :except => [:checkout, :complete_order_successfully]
  skip_before_filter :verify_authenticity_token, :only => [:complete_order_successfully]

  def index  
    @category = Category.find(:first)
    @products = @category.products

    @categories = Category.find(:all)

    if params[:_ERROR_MESSAGE]
      flash.now[:error] = params[:_ERROR_MESSAGE]
    end
  end

  def list_products
    @category = Category.find(params[:id])
    @products = @category.products
  end

  def add_to_cart
    product = Product.find(params[:id])      
    @cart = find_cart
    @items = @cart.add_product(product, params[:quantity])
  end

  def update_cart
    product = Product.find(params[:id])
    @cart = find_cart
    @items = @cart.update_product(product, params[:quantity])
  end

  def search_product
    @products = Product.find(:all, :conditions => "name LIKE '#{params[:search]}%'")
    @search_string = params[:search]
  end

  def checkout
    @cart = find_cart
    @items = @cart.items
    @invoice_no = @invoice_no = "C00033" << current_user.id.to_s
    @redirect_to_sucessfully = url_for(:controller => 'store', :action => 'complete_order_successfully')
    @redirect_to_unsucessfully = url_for(:controller => 'store', :action => 'index')
  end

  def complete_order_successfully        
    @cart = find_cart
    @order = Order.new
    @order.customer = current_user
   
    @order.pay_type = 'credit_card'
    @order.shipping_cost = @cart.shipping_cost.to_f
    @order.order_no = Order.generate_reference
    if @order.save!
      @order.items = @cart.items
      Notifier.deliver_shopping_cart_new_order(@order)
      Notifier.deliver_shopping_cart_confirm_order(@order)
      flash[:notice] = "Your order has been processed, Please download the invoice below as proof of purchase."
#      @cart.empty!
    end
    #
    @order.reload

    # Get our items from orders.
    @items = @order.line_items
  end

  def download_files
    @order = Order.find(params[:id])
    if params[:type] == "delivery_note"
      Billing::SaleInvoice.generate_invoice(@order, true)
    else
      Billing::SaleInvoice.generate_invoice @order
    end

    send_file "#{RAILS_ROOT}/tmp/sale_invoice.pdf"
  end

  def empty_cart
    session[:cart] = nil
    flash[:notice] = "Cart has been empty successfully"
    redirect_to :action => :index
  end

  def find_cart
    @cart = (session[:cart] ||= Cart.new)
  end
end
