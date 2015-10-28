FactoryGirl.define do
  factory :user do
    user_name { Faker::Name::name }
    email { Faker::Internet::email }
    password "secret123"
    password_confirmation "secret123"
  end

end
