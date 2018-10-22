class Order < ApplicationRecord
  #validations

  #relationships
  # has_and_belongs_to_many :products


  has_many :order_items


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
end
