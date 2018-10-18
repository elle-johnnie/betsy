class Product < ApplicationRecord
  validates :prod_name, presence: true, uniqueness: true
  validates :prod_name, presence: true, numericality: { only_integer: true, greater_than: 0}
  belongs_to :users
end
