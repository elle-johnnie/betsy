class User < ApplicationRecord





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
