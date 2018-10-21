class Product < ApplicationRecord
  # validations
  validates :prod_name, presence: true, uniqueness: true
  validates :inv_qty, presence: true, numericality: { only_integer: true, greater_than: -1}
  # relationships
  belongs_to :user
  has_many :reviews
  # has_and_belongs_to_many :orders

  has_and_belongs_to_many :categories
  has_many :order_items

  def self.by_category(id)
    all_products = Product.all
    category_products = []

    all_products.each do |product|
      if product.categories.find_by(id: id)
        category_products << product
      end
    end
    return category_products
  end

  def self.by_merchant(id)
    all_products = Product.all
    merchant_products = []

    all_products.each do |product|
      if product.user.id == id
        merchant_products << product
      end
    end
    return merchant_products
  end


  def avg_rating
    # sum = sum up self.reviews

    # num = self.reviews.length

    # return sum / num
  end


end
