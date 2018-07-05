# frozen_string_literal: true

class Product < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :sales
  has_and_belongs_to_many :ingredients
  accepts_nested_attributes_for :ingredients, allow_destroy: true,
                                              reject_if: ->(attr) { attr.all? { |key, value| key == '_destroy' || value.blank? } }
  validates_presence_of :name
  scope :products_by, ->(user) { where(user_id: user.id) }
end
