require "test_helper"

describe Order do


# xdescribe "validation" do
#   let(:user) { user(:one) }
#   before do
#     1.times do
#       order = create(:order)
#     end
#   end
#
#   # it "must be a valid order" do
#   #
#   #   expect(order.valid?).must_equal true
#   # end
#
#   it "must be invalid without a customer name " do
#
#     order.cust_name = nil
#
#     expect(order.cust_name.valid?).must_equal false
#     expect(order.errors.messages).must_include :cust_name
#   end
#
#   it "must be invalid without an email address or correct data type " do
#     order.cust_email = nil
#     order.cust_email = 123
#
#     expect(order.cust_email.valid?).must_equal false
#     expect(order.errors.messages).must_include :cust_email
#   end
#
#
#   it "must be invalid without a mailing address" do
#     order.mailing_address = nil
#
#     expect(order.mailing_address.valid?).must_equal false
#     expect(order.errors.messages).must_include :mailing_address
#   end
#
#
#   it "must be invalid without a customer name" do
#     order.cc_name = nil
#
#     expect(order.cc_name.valid?).must_equal false
#     expect(order.errors.messages).must_include :cc_name
#   end
#
#   # it "must be invalid if date has expired" do
#   #   order.cc_expiration = 2018/08/21
#   #
#   #   expect(order.cc_name.valid?).must_equal false
#   #   expect(order.errors.messages).must_include :cc_expiration
#   # end
#
#   it "must be invalid with more than 16 digits for credit card" do
#     order.cc_digit = 123
#     order2.cc_digit = "hi"
#
#     expect(order.cc_digit.valid?).must_equal false
#     expect(order2.cc_digit.valid?).must_equal false
#     expect(order.errors.messages).must_include :cc_digit
#     expect(order2.errors.messages).must_include :cc_digit
#   end
#
#   it "must have only 3 digits for CVV" do
#     order.cc_cvv = 12
#     order2.cc_cvv = "hi"
#
#     expect(order.cc_cvv.valid?).must_equal false
#     expect(order2.cc_cvv.valid?).must_equal false
#     expect(order.errors.messages).must_include :cc_cvv
#     expect(order2.errors.messages).must_include :cc_cvv
#   end
#
#   it "must be 5 digits in length for zip code" do
#     order.cc_zip = 12
#     order2.cc_zip = "hi"
#
#     expect(order.cc_zip.valid?).must_equal false
#     expect(order2.cc_zip.valid?).must_equal false
#     expect(order.errors.messages).must_include :cc_zip
#     expect(order2.errors.messages).must_include :cc_zip
#   end
#
#
# xdescribe "relations" do
#
#   it "belong to a product" do
#     order = product.order
#     #add the yml file
#     expect(order).must_be_instance_of Product
#     expect(order.id).must_equal product.order_id
#   end
# end

  describe "place order" do

    it "reduces inventory quantity by order item quantity" do
      order = orders(:one)
      inv_qty_before = order.order_items.first.product.inv_qty
      order_qty = order.order_items.first.qty

      order.place_order
      order = orders(:one)

      inv_qty_after = order.order_items.first.product.inv_qty
      expect(order.order_items.first.product.inv_qty).must_equal inv_qty_after
      expect(inv_qty_after).must_equal inv_qty_before - order_qty
    end
  end

end
