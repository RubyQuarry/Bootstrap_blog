require 'rails_helper'

RSpec.describe Blog, :type => :model do

  it "has a title" do
    expect(FactoryGirl.create(:blog)).to be_valid
    expect(FactoryGirl.build(:blog_error)).to_not be_valid
  end

  describe "scopes" do
      let(:blog) { FactoryGirl.create(:blog) }
      let(:blog2) { FactoryGirl.create(:unpublished_blog) }

    it "should return published blogs" do
      expect(Blog.published).to eq [blog]
      blog2.update(published: true)
      expect(Blog.published).to eq [blog, blog2]
    end

    it "should search for the correct keyword" do
      expect(Blog.search('sea')).to eq [blog2]
      expect(Blog.search('none')).to eq [] # empty test
    end

    it 'should return blogs inorder' do
      expect(Blog.inorder).to eq [blog, blog2]
    end


    it 'should only return blogs in the same month' do
      expect(Blog.monthly(Date.new(2014, 7))).to eq [blog2]
    end

    it 'should work for archive months' do
        expect(Blog.archive_months).to eq []
    end
  end
end

