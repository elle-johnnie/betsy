require 'pry'
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
    # self.products.each decrease inventory
      # find qty in OrdersProducts by order_id & product_id

    # self.order = "paid"

    # clears current cart ()

  end

  def date_of_order
    return self.created_at.strftime("%B %d, %Y")
  end
end
