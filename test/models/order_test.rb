require "test_helper"

describe Order do
  let(:order) { Order.new }

  describe "validation" do
    before do
      order = create(:order)
    end

    it "must be a valid order" do

      expect(order.valid?).must_equal true
    end

    it "must be invalid without a customer name " do
      order.cust_name = nil

      expect(order.cust_name.valid?).must_equal false
      expect(order.errors.messages).must_include :cust_name
    end

    it "must be invalid without an email address " do
      order.cust_email = nil

      expect(order.cust_email.valid?).must_equal false
      expect(order.errors.messages).must_include :cust_email
    end


    it "must be invalid without a mailing address" do
      order.mailing_address = nil

      expect(order.description.valid?).must_equal false
      expect(order.errors.messages).must_include :mailing_address
    end


    it "must be invalid without a customer name" do
      order.cc_name = nil

      expect(order.cc_name.valid?).must_equal false
      expect(order.errors.messages).must_include :price
    end


    it "must have a unique name for each order" do
      order = orders(:one)
      order2 = orders(:one)

      expect(order2.name.valid?).must_equal false
    end
  end


  describe "relations" do

    it "belong to a user" do
      order = user.order
      #add the yml file
      expect(order).must_be_instance_of User
      expect(order.id).must_equal user.order_id
    end

    it "can have a rating" do
      order = rating.order
      expect(order).must_be_instance_of Review
      expect(order.id).must_equal review.order_id
    end
end
