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

    self.order_items do |order_item|
      product_id = order_item.product_id
      order_quantity = order_item.qty
      product = Product.find_by(id: product_id)
      # get quantity
      quantity = product.inv_qty
      # substract amount defined in order
      quantity -= order_quantity
      # save quantity in product
      product.inv_qty = quantity
      product.save
    end
    self.status = "Paid"
    self.save
  end

  def date_of_order
    return self.created_at.strftime("%B %d, %Y")
  end
end
