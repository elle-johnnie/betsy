class Order < ApplicationRecord
  #validations

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
