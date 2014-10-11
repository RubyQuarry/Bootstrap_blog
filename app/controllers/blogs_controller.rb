class BlogsController < ApplicationController

  before_action :sort_blogs, only: [:search, :index]

  def index
  end

  def show
    @blog = Blog.find(params[:id])
    @comment = Comment.new
    @comments = @blog.comments.inorder
  end

  def search
    if params[:keyword] # keyword query
      @blogs = @blogs.search(params[:keyword])
    elsif params[:month] && params[:year]   # archive query
      month = Date.new(params[:year].to_i, params[:month].to_i)
      @blogs = @blogs.where(created_at: month.all_month)
    end
  end


  def edit
    @blog = Blog.find(params[:id])
  end


  def update
    @blog = Blog.find(params[:id])
    if @blog.update(blog_params)
      redirect_to :action => 'show', :id => @blog
    else
      render :back
    end
  end

  private

  def sort_blogs
    @blogs = Blog.inorder.paginate(page: params[:page], per_page: 4)
  end

  def blog_params
    params.require(:blog).permit(:author, :content, :title)
  end

end
