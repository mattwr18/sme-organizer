FactoryBot.define do
  factory :purchase do
    amount 15
    description "FactoryBot purchase"
    user
  end

  factory :second_purchase, class: "Purchase" do
    amount 20
    description "FactoryBot second purchase"
    user
  end
end
