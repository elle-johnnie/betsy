require 'pry'
class OrdersController < ApplicationController
  skip_before_action :require_login
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  # before_action :check_status, only: [:show]

  # GET /orders
  def index
    @orders = Order.all
  end

  def confirm_order
  end

  def show
    # show view used when calling rendering in update - do not remove html show page
  end

  # GET /orders/new
  def new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # must change database
  # flash notices do not have color
  # def create
  #   @order = @current_order.update(order_params)
  #   # it successfully grabs and saves all fields put in the form
  #   if @order.save
  #     flash[:success] = 'Order was successfully created.'
  #     redirect_to order_path(@order.id)
  #   else
  #     flash.now[:warning] = 'Order not created'
  #
  #     @order.errors.messages.each do |field, msg|
  #       flash.now[field] = msg
  #       end
  #
  #     render :new
  #   end
  # end


  # PATCH/PUT /orders/1
  def update
    if @current_order.order_items.nil?
      flash[:warning] = "You have zero items in your cart"
      redirect_to products_path
    else
      @current_order.update(order_params)
      @current_order.place_order # decrease inventory and change status to paid
      # show confirmation page
      @order = @current_order # needed for rendering order information in show
      render :show
      session[:order_id] = nil

    end
  end

  # DELETE /orders/1

  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def order_params
    params.require(:order).permit(:status, :cust_name, :cust_email, :mailing_address, :cc_name, :cc_digit, :cc_expiration, :cc_cvv, :cc_zip, :user_id)
  end

  # def check_status
  #   Order.check_order_status(@order)
  # end
end
