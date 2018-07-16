# frozen_string_literal: true

FactoryBot.define do
  factory :purchase do
    total 15
    description 'FactoryBot purchase'
    user
    vendor 'FactoryBot vendor'

    factory :purchase_with_ingredient do
      transient do
        ingredients_count 1

        after(:create) do |purchase, evaluator|
          create_list(:ingredient, evaluator.ingredients_count, purchases: [purchase])
        end
      end
    end
  end

  factory :second_purchase, class: 'Purchase' do
    total 20
    description 'FactoryBot second purchase'
    user
    vendor 'FactoryBot second vendor'
  end
end
