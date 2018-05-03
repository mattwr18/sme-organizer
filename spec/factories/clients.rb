FactoryBot.define do
  factory :client do
    name "Aarya"
    address "FactoryBot address"
    obs "Some FactoryBot message"
    user
  end

  factory :second_client, class: "Client" do
    name "Emma"
    address "FactoryBot second address"
    obs "Second FactoryBot message"
    user
  end
end
