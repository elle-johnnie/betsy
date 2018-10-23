class OrderItemsController < ApplicationController

  def create
    @order = current_order
    # check if item is in stock

    @order_item = @order.order_items.new(order_item_params)
    @order_item.save

    if @order.save

      session[:order_id] = @order.id

      redirect_to cart_path(@order.id)

    else

      flash[:warning] = "Item order not placed"
      redirect_to root_path

    end

  end

  def update
    @order = current_order
    # check if item is in stock
    @order_item = @order.order_items.find(params[:id])
    @order_item.update_attributes(order_item_params)
    @order.save

    redirect_to cart_path(@order.id)
  end

  def cart_direct
    @order = current_order
    @order_item = @order.order_items.new(product_id: params[:id], qty: 1, order_status_id: 1)
    @order_item.save
    @order.save

    session[:order_id] = @order.id

    redirect_to cart_path(@order.id)
  end

  def destroy
    @order = current_order
    @order_item = @order.order_items.find(params[:id])
    @order_item.destroy
    @order_items = @order.order_items

    redirect_to cart_path(@order.id)
  end

  private

  def order_item_params

    params.require(:order_item).permit(:product_id, :qty, :order_status_id)

  end


end
