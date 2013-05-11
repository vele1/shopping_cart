class Notifier < ActionMailer::Base
  ADMIN_EMAIL = "rechae@gmail.com"

  def shopping_cart_new_order(order)
    admin = User.administrator

    rec = if admin
           admin.email
          else
            ADMIN_EMAIL
          end

    recipients rec
    from       order.customer.email
    subject   "Shopping Cart (New Order)"
    content_type "text/html"

    body :order => order
  end

  def shopping_cart_confirm_order(order)
    admin = User.administrator
    rec = if admin
           admin.email
          else
            ADMIN_EMAIL
          end

    recipients order.customer.email
    from       rec
    subject   "Shopping Cart Confirm Order"
    content_type "text/html"

    body :order => order
  end
end
