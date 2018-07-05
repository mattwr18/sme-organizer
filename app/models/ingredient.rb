# frozen_string_literal: true

class Ingredient < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :products
  has_and_belongs_to_many :purchases
  scope :ingredients_by, ->(user) { where(user_id: user.id) }
  validates_presence_of :name
end
