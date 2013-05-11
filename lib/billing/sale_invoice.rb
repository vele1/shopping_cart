require "billing/access.rb"
module Billing
  class SaleInvoice
    class << self
      def generate_invoice(order, delivery_note = false)
        @user = order.customer
        @items = order.line_items
        @total_cost = order.total_price
        @shipping_cost = 0.0
        @total_before_tax = Billing::Access.price_excluding_vat @total_cost
        @tax = @total_cost - @total_before_tax 
                
        pdf = PDF::Writer.new
        pdf.select_font "Times-Roman"
        pdf.margins_pt(25,25,25,100)
        pdf.text " "
#        pdf.rounded_rectangle(25, 25, 560, h = 740, 5)
        pdf.rounded_rectangle(25, 765, 560, h = 740, 4)
        #all horizontal lines.
        pdf.line(25, 580, 585, 580)
        pdf.line(25, 555, 585, 555)
        pdf.line(25, 540, 585, 540)    
        pdf.line(25, 77, 585, 77)
        pdf.line(25, 45, 585, 45)
        
#        pdf.rounded_rectangle(400, 650, 580, 650, 5)
        #Vertical line to separate description and amounts
#        pdf.line(500, 567, 500, 25)
        
        # End Notice Board
        pdf.add_image_from_file("#{RAILS_ROOT}/public/images/rails.png",30,675,90,90)
        
        # Invoiced to
        pdf.add_text(240,745, "MyShop", 7)
        pdf.add_text(240,736, "(Tel) 012 9090900",7)
        pdf.add_text(240,727, "(Fax) 082 7666 468",7)
        pdf.add_text(240,718, "accounts: accounts@myshop.co.za",7)
        pdf.add_text(240,709, "support:  support@myshop.co.za",7)
        
        pdf.add_text(480,745, "Reg no 2010/0000000000",7)
        pdf.add_text(480,736, "Vat no 192828934",7)
        pdf.add_text(480,727, "308 Camara Flat",7)
        pdf.add_text(480,718, "Cnr Pretorius and Wesselles",7)
        pdf.add_text(480,709, "Arcadia ",7)
        pdf.add_text(480,700, "Pretoria",7)
        pdf.add_text(480,689, "0083",7)
        
        # Envoice to
        
        pdf.add_text(30,645,"#{@user.full_presentation_name}", 9)
        pdf.add_text(30,635,"#{@user.address1}", 9)
        pdf.add_text(30,625,"#{@user.address2}", 9)
        pdf.add_text(30,615,"#{@user.address3}", 9)
                    
        pdf.margins_pt(125,25,25,175)
        table = PDF::SimpleTable.new
        
        table.show_lines    = :all
        table.show_headings = true
        table.orientation   = :center
        table.position      = :right
        table.width = 300
        table.font_size = 10
        table.shade_rows = :none
        
        
        table.column_order.push(*["Invoice No / Reference Nr:","Invoice Date"])
        
        headings = ["Invoice No / Reference Nr:","Invoice Date"]
        headings.each do |c|
          table.columns[c] = PDF::SimpleTable::Column.new(c)
          table.columns[c].heading = c.humanize
        end
        
        data = [] 
        data << { "Invoice No / Reference Nr:" => order.order_no, "Invoice Date" => order.order_date.strftime("%Y / %m / %d")}
        
        table.data.replace data
        table.render_on(pdf)
 
       # Statement Section
        pdf.add_text(30,569, "Credit Card Purchased Items", 12)
        
        #Header
        pdf.add_text(30,543, "<strong>Code</strong>", 10)
        pdf.add_text(75,543, "<strong>Item Description</strong>", 10)
        pdf.add_text(312,543, "<strong>Unit Price</strong>", 10)
        pdf.add_text(420,543, "<strong>Quantity</strong>", 10)
        pdf.add_text(510,543, "<strong>Total Price</strong>", 10)
        
        # Additional services.
        count_line = 528
        @items.each do |item|
          product = item.product
          price_exc_vat = Billing::Access.price_excluding_vat(item.unit_price)
          total_price_exc_vat = Billing::Access.price_excluding_vat(item.quantity * product.price)
          pdf.add_text(32,count_line, product.product_code, 10)
          pdf.add_text(77,count_line, product.name, 10)
          pdf.add_text(312,count_line, Access.money(price_exc_vat), 10)
          pdf.add_text(424,count_line, item.quantity, 10)
          pdf.add_text(512,count_line, Access.money(total_price_exc_vat), 10)
          count_line -= 12
        end
        
        # if there is shipping cost.
        if order.shipping_cost
          price_exc_vat = Billing::Access.price_excluding_vat(order.shipping_cost)
          pdf.add_text(32,count_line, 'Delvry', 10)
          pdf.add_text(77,count_line, 'Shipping Cost (Delivery)', 10)
          pdf.add_text(312,count_line, Access.money(price_exc_vat), 10)
          pdf.add_text(424,count_line, 1, 10)
          pdf.add_text(512,count_line, Access.money(price_exc_vat), 10)
        end
        
        pdf.add_text(28, 90, "<strong>Note</strong> This invoice has been submitted to MyGate credit card gateway for settle of the transaction as below, Please note that the transaction is subject", 9)
        pdf.add_text(29, 80, "         to the terms and conditions as defined on (Terms And Conditions)", 9)
        
        pdf.add_text(360, 65, "<strong>Total Excluding Tax</strong>", 10)
        pdf.add_text(530, 65, "<strong>#{Access.money(@total_before_tax)}</strong>", 10)
        
        pdf.add_text(360, 52, "<strong>Tax</strong>", 10)
        pdf.add_text(530, 52, "<strong>#{Access.money(@tax)}</strong>", 10)
        
        pdf.add_text(360, 33, "<strong>Total Include VAT</strong>", 11)
        pdf.add_text(530, 33, "<strong>#{Access.money(@total_cost)}</strong>", 11)
        pdf.save_as("#{RAILS_ROOT}/tmp/sale_invoice.pdf")
      end
    end  
  end  
end  