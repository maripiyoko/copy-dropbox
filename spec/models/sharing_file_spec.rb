require 'rails_helper'

RSpec.describe SharingFile, type: :model do
  it "should respond valid factory" do
    expect(FactoryGirl.build(:sharing_file)).to be_valid
  end
end
