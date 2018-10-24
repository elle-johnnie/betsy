class OrderItemsController < ApplicationController

  def create
    @order_item = @current_order.order_items.new(order_item_params)

    if @order_item.save
      session[:order_id] = @current_order.id
      redirect_to cart_path(@current_order.id)
    else
      flash[:warning] = "Item order not placed"
      redirect_to root_path
    end
  end

  def update
    @order_item = @current_order.order_items.find(params[:id])
    @order_item.update_attributes(order_item_params)
    @current_order.save

    redirect_to cart_path(@current_order.id)
  end

  def cart_direct
    @order_item = @current_order.order_items.new(product_id: params[:id], qty: 1, order_status_id: 1)
    @order_item.save
    @current_order.save
    session[:order_id] = @current_order.id

    redirect_to cart_path(@current_order.id)
  end

  def destroy
    @order_item = @current_order.order_items.find(params[:id])
    @order_item.destroy
    @order_items = @current_order.order_items

    redirect_to cart_path(@current_order.id)
  end

  private

  def order_item_params

    params.require(:order_item).permit(:product_id, :qty, :order_status_id)

  end


end
