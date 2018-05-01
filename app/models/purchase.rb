class Purchase < ApplicationRecord
  validates :amount, presence: true, numericality: { greater_than: 0.0 }
  validates_presence_of :description
end
