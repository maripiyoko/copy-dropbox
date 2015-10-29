require 'rails_helper'

RSpec.describe Folder, type: :model do

  it "should respond valid factory" do
    expect(FactoryGirl.build(:folder)).to be_valid
  end

  it "should be invalid without name" do
    folder = FactoryGirl.build(:folder, { name: nil })
    expect(folder.valid?).to be_falsey
  end

  it "should be invalid without user" do
    folder = FactoryGirl.build(:folder, { user: nil })
    expect(folder.valid?).to be_falsey
  end

  context "name should be unique" do

    it "single user cannot have a same name child folders in same folder" do
      user = FactoryGirl.create(:user)
      folder = FactoryGirl.create(:folder, { name: "parent_folder", user: user} )
      child_folder1 = FactoryGirl.create(:folder, { name: "child1", parent_folder: folder, user: user })
      child_folder2 = FactoryGirl.build(:folder, { name: child_folder1.name, parent_folder: folder, user: user })
      expect(child_folder2.valid?).to be_falsey
    end

    it "single user can have a same name child in different folder" do
      user = FactoryGirl.create(:user)
      folder1 = FactoryGirl.create(:folder, { user: user })
      folder2 = FactoryGirl.create(:folder, { user: user })
      child_folder1 = FactoryGirl.create(:folder, { name: "child1", user: user, parent_folder: folder1 })
      child_folder2 = FactoryGirl.build(:folder, { name: child_folder1.name, user: user, parent_folder: folder2 })
      expect(child_folder1.valid?).to be_truthy
      expect(child_folder2.valid?).to be_truthy
    end

    it "different user can have same name folders in same folder" do
      user1 = FactoryGirl.create(:user)
      user2 = FactoryGirl.create(:user)
      folder1 = FactoryGirl.create(:folder, { name: "SAMENAME", user: user1 })
      folder2 = FactoryGirl.build(:folder, { name: "SAMENAME", user: user2 })
      expect(folder1.valid?).to be_truthy
      expect(folder2.valid?).to be_truthy
    end
  end
end
