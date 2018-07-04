# frozen_string_literal: true

FactoryBot.define do
  factory :sale do
    total 10
    description 'FactoryBot Sale'
    client 'FactoryBot client'
    user
  end

  factory :second_sale, class: 'Sale' do
    total 11
    description 'FactoryBot second sale'
    client 'FactoryBot second client'
    user
  end
end
