class Order < ApplicationRecord
  #validations
  validates :cc_digit, presence: true, numericality: { only_integer: true, is: 16}
  validates :cc_expiration, presence: true, numericality: { only_integer: true, greater_than: 2018}
  # validates :publication_year, presence: true, numericality: { only_integer: true, greater_than: 0,  less_than: 2019}
  validates :email, presence: true, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  #relationships

  has_many :order_items

  def items_in_cart
    num = 0
    if self.order_items.empty?
      return nil
    else
      self.order_items.each do |item|
        num += item.qty
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
