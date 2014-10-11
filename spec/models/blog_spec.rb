require 'rails_helper'

RSpec.describe Blog, :type => :model do

  let(:blog_error) { Blog.create(title: "aj",
                           content: "this title") }

  let(:blog) { Blog.create(title: "aj",
                           content: "this title",
                           author: "Bill Gates") }
  it "has a title" do
    expect(blog).to be_valid
    expect(blog_error).to_not be_valid
  end

end
