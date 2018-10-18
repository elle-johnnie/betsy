class Order < ApplicationRecord
<<<<<<< HEAD
  has_many :order_items



  def total_price
    order_items.collect { |order_item| order_item.quantity * order_item.unit_price }.sum

  end

  def place_order
    # self.products.each decrease inventory
      # find qty in OrdersProducts by order_id & product_id

    # self.order = "paid"

    # clears current cart ()

  end
=======
  has_many :products
>>>>>>> 7c43e0f5f0607301dda2104e44013f217f0a8853
end
