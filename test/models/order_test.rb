require "test_helper"

describe Order do


  describe "validation" do
    let(:order)  { build(:order) }

    it "must be invalid without a customer name " do
      order.cust_name = nil

      expect(order.valid?).must_equal false
      expect(order.errors.messages).must_include :cust_name
    end

    it "must be invalid without an email address or correct data type " do
      order.cust_email = nil
      order.cust_email = 123

      expect(order.valid?).must_equal false
      expect(order.errors.messages).must_include :cust_email
    end


    it "must be invalid without a mailing address" do
      order.mailing_address = nil

      expect(order.valid?).must_equal false
      expect(order.errors.messages).must_include :mailing_address
    end


    it "must be invalid without a customer name" do
      order.cust_name = nil

      expect(order.valid?).must_equal false
      expect(order.errors.messages).must_include :cust_name
    end

    # it "must be invalid if date has expired" do
    #   order.cc_expiration = 2018/08/21
    #
    #   expect(order.cc_name.valid?).must_equal false
    #   expect(order.errors.messages).must_include :cc_expiration
    # end

    it "must be invalid with less than 16 digits for credit card" do
      order.cc_digit = 123

      expect(order.valid?).must_equal false
      expect(order.errors.messages).must_include :cc_digit

      order.cc_digit = "hi"

      expect(order.valid?).must_equal false
      expect(order.errors.messages).must_include :cc_digit
    end

    it "must have only 3 digits for CVV" do
      order.cc_cvv = 12

      expect(order.valid?).must_equal false
      expect(order.errors.messages).must_include :cc_cvv

      order.cc_cvv = "hi"

      expect(order.valid?).must_equal false
      expect(order.errors.messages).must_include :cc_cvv
    end

    it "must have only 16 digits for Credit Card number" do
      order.cc_digit = 1234123412341234

      expect(order.valid?).must_equal true
    end

    it "must be 5 digits in length for zip code" do
      order.cc_zip = 1255

      expect(order.valid?).must_equal false
      expect(order.errors.messages).must_include :cc_zip

      order.cc_zip = "hi"

      expect(order.valid?).must_equal false
      expect(order.errors.messages).must_include :cc_zip
    end


  # describe "relations" do
  #
  #   it "belong to a product" do
  #     expect(order.user).must_be_instance_of User
  #     expect(order.user.orders).must_include Order
  #   end
  # end

end
end
