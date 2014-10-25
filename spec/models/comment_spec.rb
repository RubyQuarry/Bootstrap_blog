require 'rails_helper'

RSpec.describe Comment, :type => :model do

  it "should be valid" do
    expect(FactoryGirl.create(:comment)).to be_valid
  end

  it "should not be valid" do
    expect(FactoryGirl.build(:comment_error)).to_not be_valid
  end
end
