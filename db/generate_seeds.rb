
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

CSV.open('db/product_seeds.csv', "w", :write_headers=> true,
         :headers => ["category", "prod_name", "description", "price", "inv_qty"]) do |csv|

  30.times do
    category = %w(birthday wedding chocolate vanilla buttercream).sample
    prod_name = Faker::Dessert.variety + ' ' + Faker::Dessert.topping + ' ' + Faker::Dessert.flavor
    description = Faker::Coffee.notes
    price = Faker::Number.decimal(2, 2)
    inv_qty = Faker::Number.between(0, 30)

    csv << [category, prod_name, description, price, inv_qty]
  end
end


CSV.open('db/review_seeds.csv', "w", :write_headers=> true,
         :headers => ["rating", "description"]) do |csv|

  10.times do
    rating = Faker::Number.between(1, 5)
    description = ["Tasted like ", "Deliciously flavored ", "Oddly it smelled like "].sample + Faker::Coffee.notes

    csv << [rating, description]
  end
end


CSV.open('db/order_seeds.csv', "w", :write_headers=> true,
         :headers => ["status", "cust_name", "cust_email", "mailing_address",
                      "cc_name", "cc_digit", "cc_expiration", "cc_cvv",
                      "cc_zip"]) do |csv|

  10.times do
    status = %w(pending paid complete cancelled).sample
    cust_name = Faker::RuPaul.queen
    cust_email = Faker::Internet.safe_email
    mailing_address = Faker::Address.full_address
    cc_name = Faker::FunnyName.two_word_name
    cc_digit = Faker::Finance.credit_card
    cc_expiration = Faker::Business.credit_card_expiry_date
    cc_cvv = Faker::Number.number(3)
    cc_zip = Faker::Number.number(5)

    csv << [status, cust_name, cust_email, mailing_address, cc_name, cc_digit, cc_expiration, cc_cvv, cc_zip]
  end
end

