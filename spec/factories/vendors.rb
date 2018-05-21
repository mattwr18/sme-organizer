# frozen_string_literal: true

FactoryBot.define do
  factory :vendor do
    name 'FactoryBot vendor'
    phone_number '555-1212'
    obs 'Pay ontime'
    user
  end

  factory :second_vendor, class: 'Vendor' do
    name 'FactoryBot second vendor'
    phone_number '555-2121'
    obs 'You need to pay'
    user
  end
end
