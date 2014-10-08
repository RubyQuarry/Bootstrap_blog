class BlogsController < ApplicationController

  before_action :sort_blogs, only: [:search, :index]

  def index
  end

  def show
    @blog = Blog.find(params[:id])
  end

  def search
    if params[:keyword] # keyword query
      @blogs = @blogs.search(params[:keyword])
    elsif params[:month] && params[:year]   # archive query
      month = Date.new(params[:year].to_i, params[:month].to_i)
      @blogs = @blogs.where(created_at: month.all_month)
    end
  end

  private

  def sort_blogs
    @blogs = Blog.inorder.paginate(page: params[:page], per_page: 4)
  end

end
