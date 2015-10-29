FactoryGirl.define do
  factory :sharing_file do
    association :folder_file
    association :user
  end

end
