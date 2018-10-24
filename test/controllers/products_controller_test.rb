require "test_helper"

describe ProductsController do
  let(:product)  { build(:product) }

  it "gets index" do
    get products_url
    value(response).must_be :successful?
  end

  it "gets new" do
    get new_product_path
    value(response).must_be :successful?
  end

  it "creates product" do
    id = users(:laura).id
    product_hash = { product: { prod_name: product.prod_name, description: product.description, price: product.price, inv_qty: product.inv_qty, user: id } }

    expect {
      post products_path, params: product_hash
    }.must_change "Product.count"

    must_redirect_to user_path(session[:user_id])
    expect(flash[:notice]).must_equal "#{@product.prod_name} was successfully created."
  end

  it "shows product" do
    id = products(product).id

    get product_path(id)
    value(response).must_be :successful?
  end

  it "gets edit" do
    id = products(:cake1).id

    get edit_product_path(id)
    value(response).must_be :successful?
  end

  it "updates product" do
    id = products(:cake1).id

    patch product_path(id)
    must_redirect_to product_path(product)
  end

  it "destroys product" do
    id = products(:cake1).id

    expect {
      delete product_path(id)
    }.must_change "Product.count", -1

    must_redirect_to products_path
  end
end
