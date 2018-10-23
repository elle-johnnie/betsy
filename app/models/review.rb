class Review < ApplicationRecord
  #validations
  validates :rating, presence: true, numericality: { only_integer: true, greater_than: 0, less_than: 6}
  validates :user, uniqueness: { scope: :product, message: "can't review own work" }
  #relationships
  belongs_to :product
end
