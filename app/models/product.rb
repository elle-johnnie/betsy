class Product < ApplicationRecord
  has_many :order_items

  validates :prod_name, presence: true, uniqueness: true
  validates :inv_qty, presence: true, numericality: { only_integer: true, greater_than: 0}
  belongs_to :users
<<<<<<< HEAD
  has_many :reviews
  has_and_belongs_to_many :orders
=======




  def avg_rating
    # sum = sum up self.reviews

    # num = self.reviews.length

    # return sum / num
  end



>>>>>>> b5b2f384e229a73a670fb028ef16ef6a43759ab7
end
