require "test_helper"

describe ReviewsController do
  let(:review) { reviews :one }

  it "gets index" do
    get reviews_url
    value(response).must_be :successful?
  end

  # describe "show" do

  # it "gets a review show page" do
  #   id = products(:cake1).id
  #
  #   get reviews_path(id)
  #   value(response).must_be :successful?
  # end

  #   it "shows review" do
  #     get review_url(review)
  #     value(response).must_be :successful?
  #   end
  #
  # end

  #  it "should repond with not_found if given an invalid id" do
  #    id = -1
  #
  #    get new_product_review_path(id)
  #
  #    value(response).must_be :not_found
  # end
  # end


  describe "new" do

    it "gets the form with the new review page" do
      id = products(:cake1).id

      get new_product_review_path(id)
      value(response).must_be :successful?
    end

  end

  describe "create" do

    it "creates a new review given valid params" do
      id = products(:cake1).id
      review_hash = { review: { description: review.description, rating: review.rating} }

      expect {
        post product_reviews_path(id), params: review_hash
      }.must_change "Review.count", 1

      must_redirect_to product_path(id)

      expect(Review.last.description).must_equal review_hash[:review][:description]
      expect(Review.last.rating).must_equal review_hash[:review][:rating]
    end

    it "respond with an redirect for invalid params" do
      id = products(:cake1).id
      review_hash = { review: { description: review.description } }

      expect {
        post product_reviews_path(id), params: review_hash
      }.wont_change "Review.count"

      must_respond_with :success
      expect(flash[:warning]).must_equal "Please enter all fields"
    end

    # it "respond with an error if merchant reviews their own product" do
    #   get "/auth/github", params: {username: "laura"}
    #   expect(session[:user_id]).wont_be_nil
    #
    #   id = products(:cake1).id
    #   review_hash = { review: { description: review.description, rating: review.rating} }
    #
    #   expect {
    #     post product_reviews_path(id), params: review_hash
    #   }.wont_change "Review.count"
    #
    #   must_redirect_to products_path
    #   expect(flash[:warning]).must_equal "You can't review your own Product"
    # end
  end


  describe "edit" do

    it "can get the edit page for a valid review" do
      id = products(:cake1).id

      get edit_review_url(review)
      value(response).must_be :successful?
    end

    # it "should resond with not_found if given an invalid id" do
    #   id = -1
    #
    #   get review_path(id)
    #
    #   must_respond_with :not_found
    # end
  end

  it "updates review" do
    patch review_url(review), params: { review: { description: review.description, rating: review.rating } }
    must_redirect_to review_path(review)
  end

  describe "destroy" do

    it "destroys review given a valid id" do
      expect {
        delete review_url(review)
      }.must_change "Review.count", -1

      must_redirect_to reviews_path
    end

    # it "cant destroy a review given an invalid id" do
    #   id = -1
    #
    #   expect {
    #     delete book_path(id)
    #   }.wont_change 'Book.count'
    #
    #   must_respond_with :not_found
    #   expect(flash[:danger]).must_equal "Cannot find the book #{id}"
    # end
  end

end
