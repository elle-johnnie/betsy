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
    #decrease inventory
    self.order_items.each do |order_item|
      product = order_item.product
      # get quantity
      quantity = product.inv_qty
      # substract amount defined in order
      new_inv_qty = product.inv_qty - order_item.qty
      product.inv_qty = new_inv_qty

      product.update(inv_qty: new_inv_qty)
      product.save!
      binding.pry
    end
    self.status = "Paid"
    self.save!
  end

  def date_of_order
    return self.created_at.strftime("%B %d, %Y")
  end
end
