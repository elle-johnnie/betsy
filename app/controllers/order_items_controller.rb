class OrderItemsController < ApplicationController
  skip_before_action :require_login
  before_action :set_order, only: [:create, :update, :cart_direct]


  def create
    product = Product.find_by(id: params[:order_item][:product_id])
    if params[:order_item][:qty].to_i > product.inv_qty
      flash[:warning] = "Quantity selected exceeds amount availabe in inventory"
      redirect_to product_path(product.id)
    else
      @order_item = @current_order.order_items.new(order_item_params)
      @current_order.save

      if @order_item.save
        session[:order_id] = @current_order.id
        redirect_to cart_path(@current_order.id)
      else
        flash[:warning] = "Item order not placed"
        redirect_to root_path
      end

    end
  end

  def update
    @order_item = @current_order.order_items.find(params[:id])

    @order_item.update_attributes(order_item_params)
    @current_order.save

    redirect_to cart_path(@current_order.id)
  end
#
# #   def cart_direct
# #     # TODO DETERMINE WHICH INSTANCE IS NEEDED
# #     # @CURRENT_ORDER OR @ORDER???????????????????
#     @order_item = @current_order.order_items.new(product_id: params[:id], qty: 1, order_status_id: 1)
# #     redirect_back(fallback_location: cart_path(@order.id))
# #   end

  def cart_direct
    # @order = current_order <- moved to controller filter
    @order_item = @current_order.order_items.new(product_id: params[:id], qty: 1, shipped: false)
    @order_item.save

    @current_order.save

    session[:order_id] = @current_order.id

    redirect_to cart_path(@current_order.id)
  end

  def destroy
    # TODO DETERMINE WHICH INSTANCE IS NEEDED
    #     # @CURRENT_ORDER OR @ORDER???????????????????
    @order_item = @current_order.order_items.find(params[:id])

    # @order = current_order <- moved to controller filter
    # @order_item = @order.order_items.find(params[:id])

    @order_item.destroy
    @order_items = @current_order.order_items

    redirect_to cart_path(@current_order.id)
  end

  def ship
    @order_item = OrderItem.find_by(product_id: params[:id])
    @order_item.shipped = true
    Order.check_order_status(@current_order)
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
