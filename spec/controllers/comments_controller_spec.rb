require 'rails_helper'

RSpec.describe CommentsController, :type => :controller do

  subject { page }

  describe 'Submit comment' do

    before :each do
      @blog = Blog.create!(author:     "aj",
                           title:      "hello, world",
                           content:    "#Welcome ",
                           keywords:   "runner,YOLO",
                           created_at: 5.seconds.ago,
                           published:  true)
      visit blog_path(@blog)

      fill_in('comment_email', :with => 'John@email.com')
      fill_in('comment_name',  :with => 'John')
    end

    it 'should be successful' do
      expect(@blog.comments.count).to eq(0)
      fill_in('comment_text',  :with => 'Comment')
      page.has_content?('Submit comment')
      expect{ click_on('Submit') }.to change(@blog.comments, :count).by(1)
    end

    it 'should not be successful' do
      expect{ click_on('Submit') }.not_to change(@blog.comments, :count)
    end
  end

end
