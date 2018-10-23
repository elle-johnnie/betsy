require "test_helper"

describe Review do
  let(:review) { Review.new }
  let(:review1) {create(:review)}
  let(:one) {create(:one)}

  it "must be valid" do
    expect(review.valid?).must_equal true
  end

  describe "relations" do

    it "must respond to product" do
      expect(review).must_respond_to :product
    end

  end

  describe "validations" do

    it "allows one user to vote for multiple works" do
      vote1 = Vote.new(user: user1, work: work1)
      vote1.save!
      vote2 = Vote.new(user: user1, work: work2)
      vote2.valid?.must_equal true
    end

    it "allows multiple users to vote for a work" do
      vote1 = Vote.new(user: user1, work: work1)
      vote1.save!
      vote2 = Vote.new(user: user2, work: work1)
      vote2.valid?.must_equal true
    end

    it "doesn't allow the same user to vote for the same work twice" do
      vote1 = Vote.new(user: user1, work: work1)
      vote1.save!
      vote2 = Vote.new(user: user1, work: work1)
      vote2.valid?.must_equal false
      vote2.errors.messages.must_include :user
    end
  end
end
end
