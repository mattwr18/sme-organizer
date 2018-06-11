# frozen_string_literal: true

FactoryBot.define do
  factory :ingredient do
    name 'FactoryBot ingredient'
    amount 1
    amount_type 'gram(s)'
  end

  factory :second_ingredient, class: 'Ingredient' do
    name 'FactoryBot second ingredient'
    amount 3
    amount_type 'kilo(s)'
  end
end
