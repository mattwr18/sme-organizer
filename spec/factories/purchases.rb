# frozen_string_literal: true

FactoryBot.define do
  factory :purchase do
    amount 15
    description 'FactoryBot purchase'
    user
    vendor 'FactoryBot vendor'
  end

  factory :second_purchase, class: 'Purchase' do
    amount 20
    description 'FactoryBot second purchase'
    user
    vendor 'FactoryBot second vendor'
  end
end
