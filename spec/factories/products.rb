# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    name 'FactoryBot product name'
    user

    factory :product_with_ingredient do
      transient do
        ingredients_count 1

        after(:create) do |product, evaluator|
          create_list(:ingredient, evaluator.ingredients_count, products: [product])
        end
      end
    end
  end

  factory :second_product, class: 'Product' do
    name 'FactoryBot second product name'
    user
  end
end
