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
    # sum = sum up self.reviews

    # num = self.reviews.length

    # return sum / num
  end




end
