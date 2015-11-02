FactoryGirl.define do
  factory :sharing_folder do
    association :folder
    association :user
  end

end
