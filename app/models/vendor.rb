class Vendor < ApplicationRecord
  belongs_to :user

  scope :vendors_by, ->(user) { where(user_id: user.id) }

  validates_presence_of :name
end
