require 'rails_helper'

RSpec.describe Blog, :type => :model do

  it "has a title" do
    expect(FactoryGirl.create(:blog)).to be_valid
    expect(FactoryGirl.build(:blog_error)).to_not be_valid
  end

  describe "deletion" do


  end


end

