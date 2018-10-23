class Order < ApplicationRecord
  #validations

  #relationships
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
      quantity -= 1 # needs to reduce by qty purchased
      product = quantity
      product.save
    end

    self.status = "Paid"
    self.save
    # order is not getting updated
    raise
    # clears current cart () erase order_id
  end


  def date_of_order
    return self.created_at.strftime("%B %d, %Y")
  end

  def check_order_status(order)
    if order.order_items.all? {|item| item.shipped}
      order.status = "Complete"
      raise
      order.save
    end
  end

  def destroy
    # method to cancel order
  end

  private

    # def set_order_status
    #   self.order_status_id = 1
    # end


end
