require "test_helper"

describe Review do
  let(:review) { Review.new }

  # it "must be valid" do
  #   value(review).must_be :valid?
  # end

  describe "relations" do

    it "has a product" do
      review = review(:cake1)
      review.must_respond_to :product
      review.product.must_be_kind_of Product
    end
  end

  describe "validations" do
    before do


    it "allows multiple users to review for a product" do
      review1 = Review.new(product: cake1)
      review1.save!
      review2 = Review.new(product: cake1)
      review2.valid?.must_equal true
    end

    # it "doesn't allow the merchant to leave a review for their own work" do
    #   review1 = Review.new(product: cake1)
    #   review1.save!
    #   review1.errors.messages.must_include :user
    # end
  end

end
