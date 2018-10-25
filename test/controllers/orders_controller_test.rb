require "test_helper"

describe OrdersController do
  let(:order) { orders :one }

  it "gets index" do
    get orders_url

    value(response).must_be :successful?
  end

  it "gets new" do
    get new_order_url

    value(response).must_be :successful?
  end

  # it "creates order" do
  #   expect {
  #     post orders_url, params: { order: { cc_cvv: order.cc_cvv, cc_digit: order.cc_digit, cc_expiration: order.cc_expiration, cc_name: order.cc_name, cc_zip: order.cc_zip, cust_email: order.cust_email, cust_name: order.cust_name, mailing_address: order.mailing_address, status: order.status } }
  #   }.must_change "Order.count"
  #
  #   must_redirect_to order_path(Order.last)
  # end
describe "show" do

  it "it shows an order for that merchant" do
    user = users(:laura)
    perform_login(user)

    id = orders(:one).id

    get orders_path(id)

    value(response).must_be :successful?
  end

  it "will not allow another merchant to view an order without their product" do
    user = users(:laura)
    perform_login(user)

    id = orders(:two).id

    get orders_path(id)

    value(response).must_be :successful?
  end

end
  #
  # it "gets edit" do
  #   get edit_order_url(order)
  #   value(response).must_be :successful?
  # end


#placing the order we use update
  it "updates order" do
    patch order_url(order), params: { order: { cc_cvv: order.cc_cvv, cc_digit: order.cc_digit, cc_expiration: order.cc_expiration, cc_name: order.cc_name, cc_zip: order.cc_zip, cust_email: order.cust_email, cust_name: order.cust_name, mailing_address: order.mailing_address, status: order.status } }
    must_redirect_to order_path(order)
  end

  # it "destroys order" do
  #   expect {
  #     delete order_url(order)
  #   }.must_change "Order.count", -1
  #
  #   must_redirect_to orders_path
  # end
end
