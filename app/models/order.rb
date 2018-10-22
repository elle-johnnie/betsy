class Order < ApplicationRecord
  #validations

  #relationships

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


  def date_of_order
    return self.created_at.strftime("%B %d, %Y")
  end

  private

    # def set_order_status
    #   self.order_status_id = 1
    # end


end
