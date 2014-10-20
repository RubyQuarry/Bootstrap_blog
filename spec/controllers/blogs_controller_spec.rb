require 'rails_helper'
require 'spec_helper'

RSpec.describe BlogsController, :type => :controller do

  include Devise::TestHelpers # add authentication to tests

  subject { page }

  describe "keyword search" do
    before :each do
      @blog = Blog.create!(  author:     "aj",
                             title:      "hello, world",
                             content:    "#Welcome ",
                             keywords:   "runner,YOLO",
                             created_at: Date.new(2014, 8, 3),
                             published:  true)
      @blog2 = Blog.create!( author:     "aj",
                             title:      "hello, world",
                             content:    "#Welcome ",
                             keywords:   "runner",
                             created_at: Date.new(2014, 8, 4),
                             published:  true)
      get :index
      expect(assigns(:blogs)).to match_array([@blog, @blog2])
    end

    it "should search for keyword" do
      get :search, keyword: 'YOLO'
      expect(assigns(:blogs)).to match_array([@blog])
    end

    it "should search for a date thats not there" do
      get :search, month: '9', year: '2014'
      expect(assigns(:blogs)).to match_array([])
    end

    it "should search for a date that exists" do
      get :search, month: '8', year: '2014'
      expect(assigns(:blogs)).to match_array([@blog, @blog2])
    end
  end


  describe "CRUD operations" do

    before :each do
      @blog = Blog.create!(  author:     "aj",
                             title:      "hello, world",
                             content:    "#Welcome ",
                             keywords:   "runner,YOLO",
                             created_at: 5.seconds.ago,
                             published:  true)

      @blog2 = Blog.create!( author:     "aj",
                             title:      "hello, world",
                             content:    "#Welcome ",
                             keywords:   "runner",
                             created_at: 5.seconds.ago,
                             published:  true)
    end
  end

end
