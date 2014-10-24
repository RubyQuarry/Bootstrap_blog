require 'rails_helper'

RSpec.describe CommentsController, :type => :controller do


  include Devise::TestHelpers # add authentication to tests

  subject { page }

  describe 'Submit comment' do

    before :each do
      @blog = FactoryGirl.create(:blog)
      visit blog_path(@blog)

      fill_in('comment_email', :with => 'John@email.com')
      fill_in('comment_name',  :with => 'John')
    end

    it 'should be successful' do
      expect(@blog.comments.count).to eq(0)
      fill_in('comment_text', :with => 'Comment')
      page.has_content?('Submit comment')
      expect{ click_on('Submit') }.to change(@blog.comments, :count).by(1)
    end

    it 'should not be successful' do
      expect{ click_on('Submit') }.not_to change(@blog.comments, :count)
    end



  end

  describe 'like comment' do
    before :each do
      @blog = FactoryGirl.create(:blog)
      @blog.comments << Comment.create(name: "aj", text: 'hi', vote: 0)
      visit blog_path(@blog)
    end

    it 'should by successful' do
      expect(page).to have_css('.like')
      expect{ click_on('Like') }.to change(@blog.comments.find_by_name("aj"), :vote).by(1)
    end

  end

end
