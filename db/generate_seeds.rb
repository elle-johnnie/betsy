require 'faker'
require 'date'
require 'csv'

# feel free to
# run this script in order to replace it and generate a new one
# run using the command:
# $ ruby db/generate_seeds.rb
# if satisfied with this new media_seeds.csv file, recreate the db with:
# $ rails db:reset
# doesn't currently check for if titles are unique against each other

CSV.open('db/products_seeds.csv', "w", :write_headers=> true,
         :headers => ["category", "prod_name", "description", "price", "inv_qty"]) do |csv|

  25.times do
    category = %w(birthday wedding chocolate vanilla buttercream).sample
    prod_name = Faker::Dessert.variety + Faker::Dessert.topping + Faker::Dessert.flavor
    description = Faker::Coffee.notes
    price = Faker::Number.decimal(2, 2)
    inv_qty = Faker::Number.between(0, 30)

    csv << [category, prod_name, description, price, inv_qty]
  end
end

