class ProductsController < ApplicationController
  skip_before_action :require_login, only: [:index, :show]
  before_action :set_product, only: [:show, :edit, :update, :destroy, :status]
  before_action :require_login, only: [:edit, :update, :create, :status]

  # GET /products
  def index
    # if user logged in then get just their products
    if session[:user_id]
      @products = @login_user.products
    else
      @products = Product.all
    end

  end

  # GET /products/1

  def show
    @product = Product.find(params[:id])
    # if @login_user
    #   @products = @login_user.products
    # end
    #
    # if @current_order.order_items.find_by(product_id: params[:id]).nil?
    # @order_item = OrderItem.new
    # else
    #   @order_item = @current_order.order_items.find_by(product_id: params[:id])
    # end
    #
    # # setting up space, creating a blank row, not filling out
    # if @order_item.nil?
    #   @order_item = current_order.order_items.new
    # end

    # @product = Product.find(params[:id])
    @reviews = Review.where(product_id: @product)
  end

  # GET /products/new
  def new

    if params[:user_id]
      # nested route: /user/user_id/products/new
      user = User.find_by(id: params[:user_id])
      @product = user.products.new
    else
      @product = Product.new
    end
  end

  # GET /products/1/edit
  def edit; end

  # POST /products
  def create
    @product = Product.new(product_params)
    @product.user_id = session[:user_id]
    if @product.save(product_params)
      flash[:notice] = "#{@product.prod_name} was added to your inventory."
      redirect_to user_path(session[:user_id])
    else
      render :new
    end
  end

  # PATCH/PUT /products/1
  def update
    if @product.update(product_params)
      flash[:notice] = "#{@product.prod_name} was successfully updated."
      redirect_to product_path
    else
      render :edit
    end
  end


  # DELETE /products/1
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
    end
  end

  def category
    @category = Category.find_by(id: params[:id])
    @products = Product.by_category(params[:id])
  end


  def status
    if @product.active
      @product.update(active: false)
      flash[:notice] = "#{@product.prod_name} status successfully updated."
      redirect_back(fallback_location: root_path)
    else
      @product.update(active: true)
      flash[:warning] = "Product could not updated."
      redirect_back(fallback_location: products_path)
    end
  end


  def merchant
    @user = User.find_by(id: params[:id])
    @products = Product.by_merchant(params[:id].to_i)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def product_params
    params.require(:product).permit(:prod_name, :description, :price, :inv_qty, category_ids: [])
  end
end
