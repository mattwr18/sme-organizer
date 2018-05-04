class Ingredient < ApplicationRecord
  has_and_belongs_to_many :products

  scope :products_by, ->(user) { where(user_id: user.id) }
end
