# frozen_string_literal: true

FactoryBot.define do
  factory :ingredient do
    name 'FactoryBot ingredient'
    amount 1
    amount_type 'MyString'
  end
end
