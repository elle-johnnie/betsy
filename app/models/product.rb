class Product < ApplicationRecord
  # validations
  validates :prod_name, presence: true, uniqueness: true
  validates :description, :price, presence: true
  validates :inv_qty, presence: true, numericality: { only_integer: true, greater_than: -1}
  # relationships
  belongs_to :user
  has_many :reviews
  # has_and_belongs_to_many :orders

  has_and_belongs_to_many :categories
  has_many :order_items

  def self.by_category(id)
    all_products = Product.all.where(active: true)
    category_products = []

    all_products.each do |product|
      if product.categories.find_by(id: id)
        category_products << product
      end
    end
    return category_products
  end

  def self.by_merchant(id)
    all_products = Product.all.where(active: true)
    merchant_products = []

    all_products.each do |product|
      if product.user.id == id
        merchant_products << product
      end
    end
    return merchant_products
  end


  # def avg_rating
  #   average_rating = self.reviews.reduce(0) { |sum, review| sum + review.rating }
  #   return average_rating
  # end


  # def self.status(product)
  #   if product.active
  #     product.update(active: false)
  #   else
  #     product.update(active: true)
  #   end
  #
  # end

  def avg_rating
    total = 0
    if self.reviews.count > 0
      self.reviews.each do |review|
        total += review.rating
      end
      avg = total/self.reviews.count
      return avg

    else
      return 0
    end
  end


end
