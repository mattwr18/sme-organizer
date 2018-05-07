# frozen_string_literal: true

class Client < ApplicationRecord
  belongs_to :user
  scope :clients_by, ->(user) { where(user_id: user.id) }

  validates_presence_of :name, :address
end
