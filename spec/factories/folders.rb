FactoryGirl.define do
  factory :folder do
    name { Faker::Lorem.characters(10) }
    association :user
    parent_folder_id nil
  end

end
