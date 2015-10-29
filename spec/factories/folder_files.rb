FactoryGirl.define do
  factory :folder_file do
    name { Faker::Lorem::characters(15) }
    association :folder
    association :user
  end

end
