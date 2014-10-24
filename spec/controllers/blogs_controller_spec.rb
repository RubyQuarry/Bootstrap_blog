require 'rails_helper'
require 'spec_helper'

RSpec.describe BlogsController, :type => :controller do

  include Devise::TestHelpers # add authentication to tests

  describe "keyword search" do
    Blog.destroy_all
    let(:blog) { FactoryGirl.create(:blog) }
    let(:blog2) { FactoryGirl.create(:sept_blog) }

    before :each do
      get :index
      expect(assigns(:blogs)).to match_array([blog, blog2])
    end

    it "should search for keyword" do
      get :search, keyword: 'YOLO'
      expect(assigns(:blogs)).to match_array([blog])
    end

    it "should search for a date thats not there" do
      get :search, month: '9', year: '2014'
      expect(assigns(:blogs)).to match_array([])
    end

    it "should search for a date that exists" do
      get :search, month: '8', year: '2014'
      expect(assigns(:blogs)).to match_array([blog])
    end
  end
end
