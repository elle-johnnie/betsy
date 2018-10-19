class Review < ApplicationRecord
  validates :rating, presence: true, numericality: { only_integer: true, greater_than: 1, less_than: 5}
  belongs_to :products
end
