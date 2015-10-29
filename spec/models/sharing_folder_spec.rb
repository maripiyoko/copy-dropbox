require 'rails_helper'

RSpec.describe SharingFolder, type: :model do

  it "should respond valid factory" do
    expect(FactoryGirl.build(:sharing_folder)).to be_valid
  end
end
