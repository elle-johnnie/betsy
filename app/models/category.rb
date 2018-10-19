class Category < ApplicationRecord
  # validations

  # relationships

  has_and_belongs_to_many :products

end
