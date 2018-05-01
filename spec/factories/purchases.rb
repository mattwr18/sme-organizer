FactoryBot.define do
  factory :purchase do
    amount 15
    description "FactoryBot purchase"
  end

  factory :second_purchase, class: "Purchase" do
    amount 20
    description "FactoryBot second purchase"
  end
end
