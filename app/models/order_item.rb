class OrderItem < ApplicationRecord
  validates :qty, numericality: { only_integer: true }

  belongs_to :product
  belongs_to :order


  # before_save :set_order_status

  def subtotal
    return self.product.price * qty
  end

  private



end
