require 'rails_helper'

RSpec.describe User, type: :model do

  it "should respond valid factory" do
    expect(FactoryGirl.build(:user)).to be_valid
  end

  it "should invalid if no name" do
    user = FactoryGirl.build(:user, { user_name: nil })
    expect(user.valid?).to be_falsey
  end

end
