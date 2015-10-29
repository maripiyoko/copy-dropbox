require 'rails_helper'

RSpec.describe FolderFile, type: :model do

  it "should have valid factory" do
    expect(FactoryGirl.create(:folder_file)).to be_valid
  end

  context "file name" do

    it "should be invalid if same file name in the same folder" do
      user = FactoryGirl.create(:user)
      folder = FactoryGirl.create(:folder, { user: user })
      file1 = FactoryGirl.create(:folder_file, { name: "TESTFILE.txt", user: user, folder: folder })
      file2 = FactoryGirl.build(:folder_file, { name: file1.name, user: user, folder: folder})
      expect(file2.valid?).to be_falsey
    end
  end
end
