# frozen_string_literal: true

class Sale < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :products

  validates :amount, presence: true, numericality: { greater_than: 0.0 }
  validates_presence_of :description
  validates_presence_of :client

  scope :sales_by, ->(user) { where(user_id: user.id) }
end
