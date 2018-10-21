class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :edit, :update, :destroy]

  # GET /reviews
  def index
    if params[:product_id]
      # This is the nested route, /author/:author_id/books/new
      product = Product.find_by(id: params[:product_id])
      @reviews = product.reviews.new

    else
      @reviews = Review.all
    end

  end

  # GET /reviews/1
  def show
  end

  # GET /reviews/new
  def new
    # @review = Review.new
    #post route to /review only

    #can't find post route for this method
    if params[:product_id]
     @product = Product.find_by(id: params[:product_id])
     @reviews = @product.reviews.new
    end

  end

  # GET /reviews/1/edit
  def edit
  end

  # POST /reviews
  def create
    @review = Review.new(review_params)

    respond_to do |format|
      if @review.save
        format.html { redirect_to @review, notice: 'Review was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end


  # PATCH/PUT /reviews/1
  # PATCH/PUT /reviews/1.json
  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to @review, notice: 'Review was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end


  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    @review.destroy
    respond_to do |format|
      format.html { redirect_to reviews_url, notice: 'Review was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def review_params
      params.require(:review).permit(:rating, :description, :product_id)
    end
end
