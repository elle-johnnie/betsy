require "test_helper"

describe OrderItemsController do
  it "should get create" do
    get order_items_create_url
    value(response).must_be :success?
  end

  it "should get update" do
    get order_items_update_url
    value(response).must_be :success?
  end

  it "should get destroy" do
    get order_items_destroy_url
    value(response).must_be :success?
  end

end