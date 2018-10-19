class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }






  def net_revenue
    # Order.all where order.products each have merchant_id == self.id

    # sum up orders

    # return net_revenue

  end

  def total_revenue(status)
    # self.net_revenue where Order.status == status

  end

  def total_orders
    # Order.all where order.products each have merchant_id == self.id

    # count up orders

    # return count
  end

  def num_orders(status)
    # self.total_orders where Order.status == status
  end


end
