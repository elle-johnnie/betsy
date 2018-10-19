class Product < ApplicationRecord
  has_many :order_items

  validates :prod_name, presence: true, uniqueness: true
  validates :inv_qty, presence: true, numericality: { only_integer: true, greater_than: 0}
  belongs_to :users

  has_many :reviews
  has_and_belongs_to_many :orders





  def avg_rating
    # sum = sum up self.reviews

    # num = self.reviews.length

    # return sum / num
  end



end
