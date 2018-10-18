class Product < ApplicationRecord
<<<<<<< HEAD
  has_many :order_items




  def avg_rating
    # sum = sum up self.reviews

    # num = self.reviews.length

    # return sum / num
  end
=======
  validates :prod_name, presence: true, uniqueness: true
  validates :prod_name, presence: true, numericality: { only_integer: true, greater_than: 0}
  belongs_to :users
>>>>>>> 7c43e0f5f0607301dda2104e44013f217f0a8853
end
