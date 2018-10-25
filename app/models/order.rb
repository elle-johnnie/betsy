class Order < ApplicationRecord
  #validations
  validates :cust_name, presence: true, format: { with: /[a-zA-Z]/ }, on: :place_order
  validates :cc_digit, presence: true, format: { with: /\b\d{4}[ -]?\d{4}[ -]?\d{4}[ -]?\d{4}\b/, maxlength: 16 }, on: :place_order
  validates :cc_expiration, presence: true, on: :place_order
  validates :cc_cvv, presence: true, format: { with: /[0-9]{3}/ }, on: :place_order
  validates :cc_zip, presence: true, format: { with: /[0-9]{5}/ }, on: :place_order
  validates :cust_email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }, on: :place_order
  validates :mailing_address, presence: true, on: :place_order
  #relationships
  has_many :order_items


  def items_in_cart
    num_in_cart = 0
    if self.order_items.empty?
      return 0
    else
      self.order_items.each do |item|
        if item.qty != nil
          num_in_cart += item.qty
        end
      end
    end
    return num_in_cart
  end

  def total_price
    self.order_items.sum do |order_item|
      product_id = Product.find_by(id: order_item.product_id)
      order_item.qty * product_id.price
    end
  end

  def place_order
    #decrease inventory
    self.order_items.each do |order_item|
      product = order_item.product
      # get quantity
      quantity = product.inv_qty
      # substract amount defined in order
      new_inv_qty = quantity - order_item.qty
      product.inv_qty = new_inv_qty
      product.update(inv_qty: new_inv_qty)
      product.save!
    end
    self.update(status: "Paid")
  end


  def date_of_order
    return self.created_at.strftime("%B %d, %Y")
  end

  def check_order_status
    @order = self
    all_shipped = true
    @order.order_items.each do |item|
      if !item.shipped
        all_shipped = false
      end
    end
    if all_shipped
      @order.update(status: "Complete")
    end

    return @order
  end

  def cancel
    if @login_user == self.user_id && self.status != "Pending"
      self.update(status: "Cancelled")
      self.order_items.subtotal = -self.order_items.subtotal

      return self
    end
  end


end
