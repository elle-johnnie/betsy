# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'

ORDER_FILE = Rails.root.join('db', 'order_seeds.csv')
puts "Loading raw order data from #{ORDER_FILE}"

order_failures = []
CSV.foreach(ORDER_FILE, :headers => true) do |row|
  order = Order.new
  order.status = row['status']
  order.cust_name = row['cust_name']
  order.cust_email = row['cust_email']
  order.mailing_address =  row['mailing_address']
  order.cc_name = row['cc_name']
  order.cc_digit = row['cc_digit']
  order.cc_expiration = row['cc_expiration']
  order.cc_cvv = row['cc_cvv']
  order.cc_zip = row['cc_zip']
  successful = order.save
  if !successful
    order_failures << order
    puts "Failed to save order: #{order.inspect}"
  else
    puts "Created order: #{order.inspect}"
  end
end

puts "Added #{Order.count} order records"
puts "#{order_failures.length} order failed to save"



PRODUCT_FILE = Rails.root.join('db', 'product_seeds.csv')
puts "Loading raw review data from #{PRODUCT_FILE}"

product_failures = []
CSV.foreach(PRODUCT_FILE, :headers => true) do |row|
  product = Product.new
  product.category = row['category']
  product.prod_name = row['prod_name']
  product.description = row['description']
  product.price =  row['price']
  product.inv_qty = row['inv_qty']
  product.active = row['active']
  product.image = row['image']
  successful = product.save
  if !successful
    product_failures << product
    puts "Failed to save product: #{product.inspect}"
  else
    puts "Created product: #{product.inspect}"
  end
end

puts "Added #{Product.count} product records"
puts "#{product_failures.length} product failed to save"

REVIEW_FILE = Rails.root.join('db','review_seeds.csv')
puts "Loading raw review data from #{REVIEW_FILE}"

review_failures = []
CSV.foreach(REVIEW_FILE, :headers => true) do |row|
  review = Review.new
  review.rating = row['rating']
  review.description = row['description']
  successful = review.save
  if !successful
    review_failures << review
    puts "Failed to save review: #{review.inspect}"
  else
    puts "Created review: #{review.inspect}"
  end
end

puts "Added #{Review.count} review records"
puts "#{review_failures.length} review failed to save"
