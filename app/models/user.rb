# frozen_string_literal: true

class User < ApplicationRecord
  has_many :sales
  has_many :purchases
  has_many :clients
  has_many :products

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
