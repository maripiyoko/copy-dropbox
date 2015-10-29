require 'rails_helper'

RSpec.describe User, type: :model do

  it "should respond valid factory" do
    expect(FactoryGirl.build(:user)).to be_valid
  end

  it "should invalid if no name" do
    user = FactoryGirl.build(:user, { user_name: nil })
    expect(user.valid?).to be_falsey
  end

  it "should respond shared_folders" do
    user1 = FactoryGirl.create(:user)
    user2 = FactoryGirl.create(:user)
    folder = FactoryGirl.create(:folder, { user: user1 })
    FactoryGirl.create(:sharing_folder, { folder: folder, user: user2})
    expect(user2.shared_folders.count).to eq(1)
    expect(folder.shared_users.count).to eq(1)
  end

  it "should respond other_users" do
    user1 = FactoryGirl.create(:user)
    10.times do
      FactoryGirl.create(:user)
    end
    expect(user1.other_users.count).to eq(10)
    expect(user1.other_users).not_to include(user1)
  end
end
