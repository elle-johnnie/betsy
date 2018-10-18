class Order < ApplicationRecord





  def total_price
    # self.products.each multiply price by qty

    # sum

    # apply tax?

    # return total

  end

  def place_order
    # self.products.each decrease inventory
      # find qty in OrdersProducts by order_id & product_id

    # self.order = "paid"

    # clears current cart ()

  end
end
