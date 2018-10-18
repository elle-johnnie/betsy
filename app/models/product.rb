class Product < ApplicationRecord
  has_many :order_items




  def avg_rating
    # sum = sum up self.reviews

    # num = self.reviews.length

    # return sum / num
  end
end
