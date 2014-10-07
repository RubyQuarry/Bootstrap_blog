class BlogsController < ApplicationController

  before_action :sort_blogs, only: [:search, :index]

  def index
    @blogs = @blogs.paginate(page: params[:page], per_page: 4)

  end

  def show
  end

  def search
    if params[:keyword]
      @blogs = @blogs.search("#{params[:keyword]}")
    elsif params[:month] && params[:year]
      month = Date.new(params[:year].to_i, params[:month].to_i)
      @blogs = @blogs.where(created_at: month.all_month)
    end
  end

  private

  def sort_blogs
    @blogs = Blog.inorder
  end

end
