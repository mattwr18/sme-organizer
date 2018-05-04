FactoryBot.define do
  factory :sale do
    amount 10
    description "FactoryBot Sale"
    client "FactoryBot client"
    user
  end

  factory :second_sale, class: "Sale" do
    amount 11
    description "FactoryBot second sale"
    client "FactoryBot second client"
    user
  end
end
