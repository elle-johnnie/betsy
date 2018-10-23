class OrderItemsController < ApplicationController
  before_action :set_order, only: [:create, :update, :cart_direct]


  def create
    @order = current_order
    # check if item is in stock
    @order_item = @order.order_items.new(order_item_params)
    if @order.save
      session[:order_id] = @order.id
      redirect_to cart_path(@order.id)
    else
      flash[:warning] = "Item order not placed"
      redirect_to root_path
    end

  end

  def update
    # @order = current_order <- moved to controller filter
    # check if item is in stock
    @order_item = @order.order_items.find(params[:id])
    @order_item.update_attributes(order_item_params)
    @order.save

    redirect_back(fallback_location: cart_path(@order.id))
  end

  def cart_direct
    # @order = current_order <- moved to controller filter
    @order_item = @order.order_items.new(product_id: params[:id], qty: 1, shipped: false)
    @order_item.save
    @order.save
    session[:order_id] = @order.id

    redirect_to cart_path(@order.id)
  end

  def destroy
    # @order = current_order <- moved to controller filter
    @order_item = @order.order_items.find(params[:id])
    @order_item.destroy
    @order_items = @order.order_items

    redirect_to cart_path(@order.id)
  end

  def ship
    @order_item = OrderItem.find_by(product_id: params[:id])
    @order_item.shipped = true
    Order.check_order_status(@order)
    if @order_item.save
      flash[:success] = 'Item(s) have been marked as shipped'
      redirect_back(fallback_location: root_path)
    else
      flash.now[:warning] = 'Error in shipment status.'
      render :show
    end

  end

  private

  def order_item_params
    params.require(:order_item).permit(:product_id, :qty, :shipped)
  end

  def set_order
    @order = current_order
  end

end
