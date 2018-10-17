require "test_helper"

describe ReviewsController do
  let(:review) { reviews :one }

  it "gets index" do
    get reviews_url
    value(response).must_be :success?
  end

  it "gets new" do
    get new_review_url
    value(response).must_be :success?
  end

  it "creates review" do
    expect {
      post reviews_url, params: { review: { description: review.description, rating: review.rating } }
    }.must_change "Review.count"

    must_redirect_to review_path(Review.last)
  end

  it "shows review" do
    get review_url(review)
    value(response).must_be :success?
  end

  it "gets edit" do
    get edit_review_url(review)
    value(response).must_be :success?
  end

  it "updates review" do
    patch review_url(review), params: { review: { description: review.description, rating: review.rating } }
    must_redirect_to review_path(review)
  end

  it "destroys review" do
    expect {
      delete review_url(review)
    }.must_change "Review.count", -1

    must_redirect_to reviews_path
  end
end
