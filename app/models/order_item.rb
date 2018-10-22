class OrderItem < ApplicationRecord
  validates :qty, numericality: { only_integer: true }

  belongs_to :product
  belongs_to :order
  belongs_to :order_status

  before_save :set_order_status

  def subtotal
    return self.product.price * qty
  end

  private

  def set_order_status
    self.order_status_id = 1
  end

end
