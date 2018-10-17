json.extract! product, :id, :category, :prod_name, :description, :price, :inv_qty, :created_at, :updated_at
json.url product_url(product, format: :json)
