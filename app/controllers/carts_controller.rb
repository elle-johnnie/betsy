class CartsController < ApplicationController
  skip_before_action :require_login, only: [:show]
  def show
    @order_items = current_order.order_items.order(:created_at)
  end
end
