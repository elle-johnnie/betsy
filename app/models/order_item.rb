class OrderItem < ApplicationRecord
  #validations - n/a
  #relationships
  belongs_to :product
  belongs_to :order





  def subtotal
    return self.product.price * qty
  end
end
