FactoryBot.define do
  sequence :email do |n|
    "test#{n}@example.com"
  end

  factory :user do
      email { generate :email }
      password "asdfasdf"
      password_confirmation "asdfasdf"
  end

  factory :non_authorized_user, class: "User" do
    email { generate :email }
    password "asdfasdf"
    password_confirmation "asdfasdf"
  end
end
