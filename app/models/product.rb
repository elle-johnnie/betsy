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




  def avg_rating
    average_rating = self.reviews.reduce(0) { |sum, review| sum + review.rating }
    return average_rating
  end

  # def avg_rating
  #   total = 0
  #   self.reviews.each do |review|
  #     total += review.rating
  #   end
  #   return total/reviews.count.to_f
  # end

end
