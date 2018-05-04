FactoryBot.define do
  factory :product do
    name "FactoryBot product name"
    user
  end

  factory :second_product, class: "Product" do
    name "FactoryBot second product name"
    user
  end
end
