class Order < ApplicationRecord
  #validations
  validates :cust_name, presence: true, format: { with: /[a-zA-Z]/ }, on: :create
  validates :cc_digit, presence: true, format: { with: /\b\d{4}[ -]?\d{4}[ -]?\d{4}[ -]?\d{4}\b/ }, on: :create
  validates :cc_expiration, presence: true, on: :create
  validates :cc_cvv, presence: true, format: { with: /[0-9]{3}/ }, on: :create
  validates :cc_zip, presence: true, format: { with: /[0-9]{5}/ }, on: :create
  validates :cust_email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }, on: :create
  validates :mailing_address, presence: true, on: :create
  #relationships

  has_many :order_items

  def items_in_cart
    num = 0
    if self.order_items.empty?
      return nil
    else
      self.order_items.each do |item|
        if item.qty != nil
          num += item.qty
        end
      end
    end
    return num
  end


  def total_price
    self.order_items.sum do |order_item|
      product_id = Product.find_by(id: order_item.product_id)
      order_item.qty * product_id.price
    end
  end

  def place_order
    #decrease inventory
    self.order_items do |order_item|
      product = Product.find_by(id: order_item.product_id)
      quantity = product.inv_qty
      quantity -= 1
      product = quantity
      product.save
    end

    self.status = "Paid"
    self.save
    # clears current cart () erase order_id

  end


  def date_of_order
    return self.created_at.strftime("%B %d, %Y")
  end

  private

    # def set_order_status
    #   self.order_status_id = 1
    # end


end
